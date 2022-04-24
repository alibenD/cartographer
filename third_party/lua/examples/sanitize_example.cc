/**-----------------------------------------------
  * @Copyright (C) All rights reserved.
  * @filename: sanitize_example.cc
  * @author: aliben.develop@gmail.com
  * @created_date: 2022-04-24 23:32:44
  * @last_modified_date: NO_LAST_MODIFIED_DATE
  * @description: TODO
  *-----------------------------------------------*/

#include <cstdio>
#include <thread>
#include <lua/dummy_test.hh>

inline static int a = 0;

void f()
{
  a++;
}

int main(int argc, char **argv)
{
  int *a = new int[10];
  a[5] = 0;
  volatile int b = a[argc];
  if (b) printf("xx\n");

  auto t1 = std::thread(&f);
  auto t2 = std::thread(&f);
  t1.join();
  t2.join();

  //int stack_array[100];
  //stack_array[1] = 0;
  //return stack_array[argc + 100]; // BOOM
}
