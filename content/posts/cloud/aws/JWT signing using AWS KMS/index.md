---
title: "JWT signing using AWS KMS"
date: 2023-01-14
lastmod: 2023-01-14
draft: false
author: "Jaejin"
authorLink: "https://jaejin1.github.io"

tags: ["aws", "go", "jwt"]
categories: ["aws"]

lightgallery: true

toc:
  auto: false
---

JWT 인증을 AWS KMS에서 key를 생성하여 이를 이용하여 token을 발급 받고 인증하는 것을 구현해보자

<!--more-->



---

**참고**

* https://github.com/matelang/jwt-go-aws-kms
