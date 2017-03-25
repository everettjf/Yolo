import os
import sys


class Node:
    def __init__(self):
        self.level = 0
        self.name = ''
        self.children = []

    def get_child(self,name):
        for node in self.children:
            if node.name == name:
                return node
        return None

    def add_child(self,name):
        node = self.get_child(name)
        if node is None:
            node = Node()
            node.name = name
            node.level = self.level + 1
            self.children.append(node)
        return node

    def add_path(self, file_path):
        file_path = file_path.lstrip('/')
        file_path = file_path.rstrip('\n')
        names = file_path.split('/')

        cur = self
        for name in names:
            cur = cur.add_child(name)

    def display(self):
        self.dfs_display(self)

    def dfs_display(self,node):
        for i in range(node.level):
            #print('+ ', end='')
            print '+',
        print(node.name)

        for child in node.children:
            self.dfs_display(child)


def get_path_array_from_file(file_path):
    path_array = []
    with open(file_path, 'r') as f:
        for line in iter(f.readline, ''):
            if not line.startswith('/Users/'):
                continue
            path_array.append(line)

    return path_array


if __name__ == '__main__':

    if len(sys.argv) != 2:
        print('please give the file path')
        exit(0)

    file_path = sys.argv[1]
    path_array = get_path_array_from_file(file_path)

    root = Node()

    i = 0
    for path in path_array:
        root.add_path(path)
        i += 1

    root.display()
