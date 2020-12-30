#include <iostream>
#include <functional>

void test(){
  std::cout << "test" << std::endl;
}

int main(){

  std::function<void(void)> test_func;

  if(!test_func){
    std::cout << "No test_func" << std::endl;
  }

  if(test_func == nullptr){
    std::cout << "No test_func == nullptr" << std::endl;
  }

  // if(test_func.target<>() != nullptr){
  //   std::cout << "No test_func != nullptr" << std::endl;
  // }

  return 0;
}