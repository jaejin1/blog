---
title: "docker file system"
date: 2021-08-16
lastmod: 2020-08-16
draft: false
author: "Jaejin"
authorLink: "https://jaejin1.github.io"
description: "docker file system"

tags: ["docker"]
categories: ["docker"]

lightgallery: true

toc:
  auto: false
---

docker에서 사용하고 있는 Union File System`(UFS)`에 대해 이해해보자.

UFS는 쉽게 여러 개의 File System을 하나로 결합하여 취급할 수 있도록 해주는 FS라 보면 된다.

<!--more-->

