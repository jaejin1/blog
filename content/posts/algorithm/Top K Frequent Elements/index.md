---
title: "[Leetcode] 347. Top K Frequent Elements"
date: 2023-02-24
lastmod: 2023-02-24
draft: false
author: "Jaejin"
authorLink: "https://jaejin1.github.io"

tags: ["algorithm", "leetcode"]
categories: ["algorithm"]

lightgallery: true

toc:
  auto: false
---

https://leetcode.com/problems/top-k-frequent-elements/description/

<!--more-->

문제 자체는 어렵지 않을 텐데 map(hash table)을 value 값으로 정렬하는데 시간을 많이 잡아먹었다.

go에선 sort interface 사용법을 알았다면 금방 풀수 있었을듯

```go
func topKFrequent(nums []int, k int) []int {
    prev := nums[0]

    tmp := map[int]int{}
    tmp[nums[0]] = 1

    for i := 1; i < len(nums); i++ {
        tmp[nums[i]] += 1
        if prev != nums[i] {
            prev = nums[i]
        }
    }
    

    keys := []int{}
    for k, _ := range tmp {
        keys = append(keys, k)
    }

    sort.Slice(keys, func(i, j int) bool {
        return tmp[keys[i]] > tmp[keys[j]]
    })

    return keys[:k]
}
```