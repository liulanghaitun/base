递归单链表反转:

#include<stdio.h>
#include<stdlib.h>
#define EXIT_SUCCESS 0
#define EXIT_FAILED 1

/**
 * 定义节点
 */
typedef struct Node
{
         int data;
         struct Node* next;
}pNode;

/**
 * 创建节点
 */
pNode* createNode(const int value)
{
     pNode* node = (pNode*)(malloc(sizeof(pNode)));
     if(NULL == node)
     {
      printf("%s\n","malloc failed!");
      exit(EXIT_FAILED);
     }
     node->next = NULL;
     node->data = value;
     return node;
}

/**
 * 创建链表
 */
pNode* createLinkList(const int* input,int length)
{
     if((NULL == input) || (0 == length))
     {
      printf("%s\n","input value error!");
      return NULL;
     }
     if(1 == length)
     {    
      return createNode(*input);
     }        
     pNode* currentNode = createNode(*input);
     pNode* nextNode = createLinkList(++input,--length);
     currentNode->next = nextNode;
     return currentNode;
}

/**
 * 反转链表
 */
pNode* reverseLinkList(pNode* currentNode,pNode* preNode)
{
     pNode* tmpNode = currentNode;
     if(NULL != (currentNode->next))
     {        
      tmpNode = reverseLinkList(currentNode->next,currentNode);
     }    
     currentNode->next = preNode;
     return tmpNode;
}

/**
 * 打印链表
 */
void printLinkList(const pNode* head)
{
      if(NULL == head)
     {    
      printf("%s\n","the LinkList is Null!");
      return ;
     }        
     printf("%d\t",head->data);
     if(NULL != (head->next))
     {
      printLinkList(head->next);
     }
}

/**
 * 主函数
 */
int main(void)
{
     const int input[5]={2,4,6,7,9};
     const int length = sizeof(input)/sizeof(input[0]);
     pNode* linkList = createLinkList(input,length);
     printLinkList(linkList);
     printf("%s\n","\n-------reverse linklist------");
     pNode* result = reverseLinkList(linkList,NULL);
     printLinkList(result);
     return EXIT_SUCCESS;
}

运算结果:
2       4       6       7       9
-------reverse linklist------
9       7       6       4       2 
