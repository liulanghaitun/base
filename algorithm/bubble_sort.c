
1.比较相邻的元素。如果第一个比第二个大，就交换他们两个。
2.对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。在这一点，最后的元素应该会是最大的数。
3.针对所有的元素重复以上的步骤，除了最后一个。
4.持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较

代码实现：
#include<stdio.h>

void bubble_sort(int* base,int lenght);

int main(void){
        int test[] = {12,23,123,42,9,63,82};
        int lenght=sizeof(test)/sizeof(test[0]);
        bubble_sort(test,lenght);
        for(int i=0;i<lenght;i++){
                printf("%d\t",test[i]);
        }
        printf("\n");
        return 1;
}
void bubble_sort(int* base,int lenght){
        int tmp_value ;
        for(int i=0;i<lenght-1;i++) {
                for(int j=0;j<lenght-i-1;j++){
                        if(*(base+j) > *(base+j+1)){
                                tmp_value=*(base+j);
                                *(base+j)=*(base+j+1);
                                *(base+j+1)=tmp_value;
                        }
                }
        }
}

结果输出：
9 12 23 42 63 82 123
