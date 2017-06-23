#include<stdio.h>
#include<stdlib.h>

/**
 * 数据交换
 */
static void swap(int* first,int* second)
{
	int tmp = *first;
	*first = *second;
	*second = tmp;
}

/**
 * 分割区间
 */
static int partiation(int array[],const int left,const int right)
{
	int baseValue = array[right];
	int tail = left - 1;
	int head;
	for(head = left;head <= right;++head)
	{
		if(array[head] <= baseValue)
		{    
			tail++;
			swap(array+tail,array+head);
		}    
	}
	return tail;
}

/**
 * 打印数组
 */
static void printArray(int input[],int length)
{
	int index ;
	for(index = 0;index<length;index++)
	{
		printf("%d\t",input[index]);
	}            
}


/**
 * 快速排序
 */
static void quickSort(int array[],const int left,const int right)
{
	if(left < right)
	{            
		const int position = partiation(array,left,right);
		quickSort(array,left,position-1);
		quickSort(array,position+1,right);
	}
}

/**
 * 主函数
 */
int main(void)
{
	int input[] = {2,89,-897,756,654,12,54};
	const int length = sizeof(input)/sizeof(input[0]);
	printArray(input,length);
	printf("%s\n","\n--------------------quickSort--------------------");
	quickSort(input,0,length-1);
	printArray(input,length);
	return EXIT_SUCCESS;
}

运行结果:
2       89      -897    756     654     12      54
--------------------quickSort--------------------
-897    2       12      54      89      654     756

