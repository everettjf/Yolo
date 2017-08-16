/**
 * Created by everettjf on 2017/4/19.
 */

'use strict';

let fs = require("fs");
let process = require("process");

function compareVersion(a, b) {
    let va = a.split('.');
    let vb = b.split('.');

    if(va.length != vb.length){
        return va.length > vb.length ? 1 : -1;
    }

    for(let idx = 0; idx < va.length; ++idx){
        let na = parseInt(va[idx]);
        let nb = parseInt(vb[idx]);

        if(na > nb)
            return 1;
        else if(na < nb)
            return -1;
    }
    return 0;
}

// console.log(compareVersion('1.0.0.0','1.0.0.20140324'));
// console.log(compareVersion('2.0.0.0','1.0.0.20140324'));
// console.log(compareVersion('1.0.0.0','1.0.0'));
// console.log(compareVersion('1','1'));
// console.log(compareVersion('1.0','1.0'));


function findMax(arr, compare) {
    if(arr.length == 0)
        return undefined;

    let max = arr[0];
    for(let idx = 1; idx < arr.length; ++idx){
        if(compare(arr[idx],arr[idx-1]) > 0){
            max = arr[idx];
        }
    }
    return max;
}

function readlinesSync(filepath) {
    let lines = fs.readFileSync(filepath, 'utf-8').split('\n');
    return lines;
}


function getDirSubDirNames(dir) {
    if(!fs.statSync(dir).isDirectory())
        return [];
    return fs.readdirSync(dir).filter(function (name) {
        if(name.startsWith("."))
            return false;
        try{
            return fs.statSync(dir + name).isDirectory();
        }catch(e){
        }
        return false;
    });
}

function getDirSubDirPaths(dir) {
    let names = getDirSubDirNames(dir);
    return names.map(x=> dir + x + "/");
}

function getAllDependenciesMap(podspecDir) {
    let data = {};

    let files = getDirSubDirPaths(podspecDir);
    for(let path of files){
        let moduleName = path.split("/").reverse()[1]
        let versions = getDirSubDirNames(path);
        if(versions.length == 0)
            continue;

        let maxVersion = findMax(versions,(a,b)=>compareVersion(a,b));

        let maxVersionPath = path + maxVersion + "/";
        let maxVersionPodspec = maxVersionPath + moduleName + ".podspec";

        if(!fs.statSync(maxVersionPodspec).isFile()){
            continue;
        }

        let lines = readlinesSync(maxVersionPodspec);
        let subspecFlag = false;
        let newLines = [];
        for(let line of lines){
            if(line.indexOf(".subspec") != -1){
                subspecFlag = true;
            }else if(subspecFlag){
                if(line.indexOf("end") != -1){
                    subspecFlag = false;
                }
            }else{
                if(! subspecFlag){
                    newLines.push(line);
                }
            }
        }
        lines = newLines.filter(x=>x.trim().indexOf("#") != 0);
        lines = lines.filter(x=>x.indexOf('.dependency') > 0).map(x=>x.trim());
        let dependencies = lines.map(function (line) {
                let items = line.split(/\.| |'|"/).filter(x=>x.length>0);
                if(items.length>3)
                    return "";
                let dep = items[2];
                return dep;
            }).filter(x=>x.length>0);

        data[moduleName] = dependencies;
    }
    return data;
}


function getModuleInUseMap(moduleName,podspecDir) {
    let allmap = getAllDependenciesMap(podspecDir);

    let usedModules = {};
    let stack = [moduleName];

    while(stack.length > 0){
        let currentModule = stack.pop();
        usedModules[currentModule] = 0;

        let dependencies = allmap[currentModule];
        if(dependencies == undefined)
            continue;

        for(let depModule of dependencies){
            if(usedModules[depModule] == undefined){
                stack.push(depModule);
            }
        }
    }

    let result = {};
    for(let key in usedModules){
        result[key] = allmap[key];
    }

    return result;
}

function wrapperstring(str) {
    str = str.replace("-","_");
    str = str.replace("/","__");
    return str;
}

function gendotfile(moduleName,podspecDir) {
    let mapdb = getModuleInUseMap(moduleName,podspecDir);

    console.log("digraph d {");

    let idx = 0;
    for(let key in mapdb){
        ++idx;

        let info = mapdb[key];
        if(info == undefined || info.length ==0)
            continue;

        let line = " " + wrapperstring(key) + " -> { "

        info.forEach(function (item) {
            line += wrapperstring(item) + " ";
        });
        line += "}"

        console.log(line);
    }
    console.log("}");
}


function run() {
    if(process.argv.length != 4){
        console.log("help : node gengraph.js AppName /xxx/specsdev/");
        return;
    }
    let specDev = process.argv[3];
    let start = process.argv[2];


    gendotfile(start,specDev);
}

run();
