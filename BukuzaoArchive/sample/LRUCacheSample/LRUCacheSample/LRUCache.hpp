/*
 * Tencent is pleased to support the open source community by making
 * MMKV available.
 *
 * Copyright (C) 2018 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef LRUCache_h
#define LRUCache_h

// 链表
#import <list>
// 无序map
#import <unordered_map>

// key和value类型
template <typename Key_t, typename Value_t>
class LRUCache {
    // 最大元素个数
    size_t m_capacity;
    // 链表存储pair
    std::list<std::pair<Key_t, Value_t>> m_list;
    // 记录key和指向链表的iterator（迭代器，类似指针）
    std::unordered_map<Key_t, typename decltype(m_list)::iterator> m_map;

public:
    LRUCache(size_t capacity) : m_capacity(capacity) {}

    // 当前占用的大小
    size_t size() const { return m_map.size(); }

    // 空间最大
    size_t capacity() const { return m_capacity; }

    // 是否包含某个key
    bool contains(const Key_t &key) const { return m_map.find(key) != m_map.end(); }

    // 清空
    void clear() {
        m_list.clear();
        m_map.clear();
    }

    // 添加
    void insert(const Key_t &key, const Value_t &value) {
        // 是否已经添加过key
        auto itr = m_map.find(key);
        if (itr != m_map.end()) {
            // 添加过
            // 则把这个元素移动到链表的最开始(iter->second移动到begin)
            m_list.splice(m_list.begin(), m_list, itr->second);
            // 覆盖key的新value
            itr->second->second = value;
        } else {
            // 是否满了
            if (m_map.size() == m_capacity) {
                // 满了（超过了设定的最大空间）
                // 移除掉链表的最后一项
                // 跟进最后一个key移除掉map中的项
                m_map.erase(m_list.back().first);
                // 移除掉链表的最后一项
                m_list.pop_back();
            }
            
            // 没有满
            // 链表最开始添加
            m_list.push_front(std::make_pair(key, value));
            // 加入map
            m_map.insert(std::make_pair(key, m_list.begin()));
        }
    }

    // 获取
    Value_t *get(const Key_t &key) {
        // 查找
        auto itr = m_map.find(key);
        if (itr != m_map.end()) {
            // 找到了
            // 移动找到的项目到链表最开始(iter->second存储了指向当前项目在链表中的迭代器)
            m_list.splice(m_list.begin(), m_list, itr->second);
            return &itr->second->second;
        }
        return nullptr;
    }
    
    // 遍历每一项
    void forEach(std::function<void(Key_t&,Value_t&)> callback){
        for(auto & item : m_list){
            callback(item.first,item.second);
        }
    }
};

#endif /* LRUCache_h */
