# 메모리 영역 Heap, Stack 살펴보기


Application memory 구조의 Heap과 Stack을 살펴보자.

<!--more-->

# memory

[이전글](https://jaejin1.github.io/2019/11/06/os/ComputerStructure/)에서 Process/Thread를 얘기할때 Memory에 대한 언급을 잠깐 했다. 여기서 사용하는 Memory는 Virtual Memory라고..

모든 프로세스가 실제의 메모리를 사용하게 되면 용량 문제가 발생하기 때문에 페이징 기법과 가상메모리를 사용한다.

흔히 코드에서 출력하는 주소값들은 가상주소이다.

## 페이징기법

계산기의 GUI가 있다고하자. +, -, *, % 등의 연산을 할때 이는 페이징 파일에 저장된다. 

페이징 파일에 아직 동작하지 않은 주소를 저장 시켜서 잠시 가지고 있는것.. 이와같이 페이징 파일을 가지고 있기에 모든 프로세스가 더 적게 메모리를 사용하는 것이다.

## 가상메모리

프로그램을 동작하면 가상 메모리 공간이 생성된다. 그 메모리 공간은 상위, 하위 메모리로 나눠진다.

### 상위 메모리

Stack의 메모리 공간이 할당된다. 지역변수, 리턴값등을 저장.. 값이 싸다. 이유는 할당과 해제는 CPU 명령어 2개로 끝난다고 한다. (할당, 해제)

코드로 예를 들면 함수가 종료되면 함수에 있던 모든 변수가 Stack에서 Pop된다고 생각하면 된다. 함수가 사라지면 외부에서 참조 못하는 것처럼

여기서 학부시절에 그렇게 많이 들은 Stack Overflow, Underflow등이 일어나게 되는 것이다.

### 하위 메모리

Heap이 생성된다. 프로그램이 동작할 때 필요한 데이터 정보를 임시로 저장. heap할당은 비싸다.

C에서 보면 malloc(), free()등으로 조작가능. Go, Python같은 언어들은 자동으로 GC가 작동하기 때문에 개발자가 신경 안써도 되는 경우도 있다. 

하지만 코드를 작성할때 신경써야하는 부분이 있을 수도 있는데 Go를 예로 들어보면

#### Go에서 heap

Go에서 포인터를 사용하면 대부분 heap에 할당 된다고 한다. 가능한 안쓰는게 좋겠지..?

포인터를 사용하지 않고 값을 복사하는 것이 memory를 작게써 CPU 캐시 적중률이 오른다고한다. 

또한 포인터를 포함하지 않는 메모리 영역은 GC가 생략할 수 있다. 반대로 포인터가 있으면 GC가 스캔 할 필요가 있다.

이렇게 GC가 돌면 메모리 상에 흩어진 영역을 계속 탐색하기 때문에 무거워 지기 때문에 개발자는 조금이라도 가볍게 개발하기 위해서는 알아야 하는 개념이다.