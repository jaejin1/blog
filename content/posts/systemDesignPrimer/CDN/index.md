---
title: "Content delivery network"
date: 2021-02-16T21:23:00+09:00
lastmod: 2021-02-16T21:23:00+09:00
draft: false
author: "Jaejin"
authorLink: "https://jaejin1.github.io"
description: "Content delivery network"

tags: ["system-design"]
categories: ["system-design"]

lightgallery: true

toc:
  auto: false
---

CDN(content delivery network)은 전 세계적으로 분산 된 프록시 서버 네트워크로, 사용자와 가까운 위치에서 콘텐츠를 제공한다. 

<!--more-->

## CDN

일반적으로 정적 파일을 제공한다. 예를 들어 HTML, CSS, JS, 사진 및 비디오 같은 것들. 하지만 AWS의 CloudFront와 같은 일부 CDN은 다이나믹 콘텐츠를 지원한다. DNS은 클라이언트에게 연결할 서버를 알려준다.

CDN에서 콘텐츠를 제공하면 다음과 같은 이점이 있다.

* 사용자는 가까운 데이터 센터에서 콘텐츠를 받음.
* 서버는 CDN이 수행하는 요청을 처리 할 필요가 없음.
* 만약 1대의 CDN서버가 장애가 나도 다른 CDN서버로 재연결 하기 때문에 안정성 또한 보장

### Push CDNs

서버에서 변경사항이 발생할 때마다 새 콘텐트를 CDN이 수신한다. CDN에 업로드 및 CDN의 URL에 관리의 모든 책임은 사용자에게 있다.

콘텐츠가 만료되는 시기와 업데이트시기를 구성할 수 있다. 새로운 콘텐츠나 변경된 경우에만 업로드 되어 트래픽을 최소화 하지만 스토리지는 최대화 한다.

트래픽이 적은 사이트 또는 자주 업데이트 되지 않는 콘텐츠가 있는 사이트는 CDN에 콘텐츠 업로드가 잘된다. 콘텐츠를 정기적으로 가져오는 대신 한번만 가져온다.

### Pull CDNs

처음 이용하는 사용자는 콘텐츠를 요청할 때 서버에서 새 콘텐츠를 가져온다. 콘텐츠를 서버에 남겨두고 CDN의 URL을 rewrite한다. 이로 인해 콘텐츠가 CDN에 캐시 될 때 까지 요청 속도가 느려진다.

TTL(time to live)는 콘텐츠가 캐시되는 기간을 결정함. Pull 이벤트는 CDN의 저장공간을 최소화 하지만 파일이 실제로 변경되기 전에 파일이 만료되고 Pull되면 중복 트래픽을 생성 할 수 있다.

트래픽이 많은 사이트는 최근 요청된 콘텐츠만 CDN에 남아있는 상태에서 트래픽이 더 균등하게 분산되기 때문에 Pull하는 방식이 잘 맞다.

### CDN의 단점

* CDN 비용은 트래픽에 따라 많이 발생할 수 있지만 CDN을 사용하지 않아도 추가 비용이 나올 수 있다.
* TTL(time to live)이 만료되기 전에 업데이트 되면 콘텐츠가 오래 되었을 수 있다.
* 정적 콘텐츠가 CDN을 가리 키도록 URL을 변경해야 한다.


## GSLB 

이런 것들을 가능하게 하는 기술은 `GSLB`라고 한다.

간단하게는 물리적으로 가깝거나 여유 트래픽이 남아 있는 곳으로 접속을 유도하는 기술.

GSLB(Global Server Load Balancing)은 이름에서 보이는 것 같이 로드 밸런서의 종류, 발전된 것이라고 생각할 수 있지만 DNS의 발전한 상태이다. 

DNS는 [이전 글](https://jaejin1.github.io/doamin/)에서 봤듯이 도메인 이름을 IP주소로 변환하는 일을 하는 서비스이다. DNS는 클라이언트가 질의를 할 경우 IP 목록을 확인해서 그 중 하나만 반환한다. 네트워크 지연, 성능등은 전혀 고려하지 않는다. 

이러한 문제를 해결한게 GSLB이다.

### GSLB vs DNS

#### 재해 복구

DNS는 서버의 상태를 알 수 없어서 서비스를 실패하는 유저가 생길 수 있다.

GSLB는 서버의 상태를 모니터링 하고 싶래한 서버의 IP는 응답에서 제외 시키므로, 유저는 서비스를 이용할 수 있다.

#### 로드 밸런싱

DNS는 Round Robin을 이용하여 정교한 로드밸런싱이 힘들다.

GSLB는 서버의 로드를 모니터링하기 때문에 로드가 적은 서버의 IP를 반환하여 정교하게 로드밸런싱할 수 있다.

#### latency 기반 서비스

DNS는 Round Robin방식이므로 네트워크상에서 멀리 떨어진 위치의 서버로 연결 할 수 있다.

GSLB는 지역별로 latency를 가지고 있기 때문에 유저가 접근하면 낮은 latency를 가지고 있는 서버로 연결한다.

#### 위치 기반 서비스 

DNS에서 유저는 역시 ROund Robin하게 서버 연결

GSLB는 유저의 지역을 기반으로 해당 지역을 서비스하는 서버로 연결할 수 있다.

---

**참고**

* https://goddaehee.tistory.com/173
* https://github.com/donnemartin/system-design-primer