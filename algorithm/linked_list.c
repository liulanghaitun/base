#include <stdio.h>
#include <stdlib.h>

typedef struct node 
{
    int index;
    struct node* next;
}list_node;

list_node *create_node(int data)
{
    list_node * head = malloc(sizeof(list_node));
    if(head)
    {
        head->index = data;
        head->next = NULL;
    }
    return head;
}


void add_node(list_node* head ,int date)
{
    while(head->next)
    {
        head = head->next;
    }
    head->next = create_node(date);
}

int insert_node(list_node** current,int position,int data)
{
    list_node* baseNode = NULL;
    list_node* newNode = NULL;
    int index = 0;
    while(*current)
    {
        baseNode = *current;
        if(index++ == position)
        {
            newNode = create_node(data);
            newNode->next = baseNode;
            *current = newNode;
            return 0;
        }
        current = &baseNode->next;
    }
    if(index == position)
     {
         newNode = create_node(data);
        *current = newNode; 
     }
    return 0;
} 

list_node* insert_list_node(list_node** current,int position,int data)
{
    if(*current)
    {
        if(position == -1)
        {
             list_node* message= create_node(data); 
             message->next = *current;
             return message;
        }else{
            (*current)->next = insert_list_node(&(*current)->next,--position,data);
            return *current;
        }
    }
    return position == -1?create_node(data):NULL;
}

list_node* del_list_node(list_node** current,int position)
{
    if(*current)
    {
        if(position == -1)
        {
            list_node* message = (*current)->next;
            free(*current);
            *current = NULL;
            return message;
        }else{
             (*current)->next = del_list_node(&(*current)->next,--position);
            return *current;
        }
    } 
    return NULL;
}

list_node* lookup_list_node(list_node** current, int position)
{
    if(*current)
    {
        if(position == -1)
        {
            return *current;
        }else{
            return lookup_list_node(&(*current)->next,--position);
        }
    } 
    return NULL;
}

list_node* replace_list_node(list_node** current, int position,int data)
{
    if(*current)
    {
        if(position == -1)
        {
            (*current)->index = data;
        }else{
             (*current)->next = replace_list_node(&(*current)->next,--position,data);
        }
        return *current;
    } 
    return NULL;
}


void del_node(list_node **current,int data)
{
    list_node* baseNode = NULL;
    while(*current)
    {
        baseNode = *current;
        if(baseNode->index == data)
        {
            *current = baseNode->next;
            free(baseNode);
            baseNode = NULL;
            return;
        }
        current = &baseNode->next;
    }
}


list_node* create_list(const int *input,int length)
{
    if(length == 1)
    {
        return create_node(*input);
    }
    list_node* current = create_node(*input);
    current->next = create_list(++input,--length);
    return current;
}


list_node* reverse_list(list_node* input,struct node* pre_input)
{
    list_node* current = input;
    if(current->next)
    {
        current = reverse_list(current->next,current); 
    }
    input->next = pre_input;
    return current;
}

void del_list(list_node* input)
{
    list_node* current = input;
    while(current)
    {
        printf("delete:%d\r\n",input->index);
        current = input->next;
        free(input);
        input = current;
    }
}

void print_list(list_node* head)
{
    while(head->next)
    {
        printf("%d ",head->next->index);
        head = head->next;
    }
}


int main(void)
{
       int value[] = {0,13,26,39,41,56,67,70};
       list_node *head = create_node(-1);
       head->next = create_list(value,sizeof(value)/sizeof(value[0]));
       print_list(head);
       head->next = reverse_list(head->next,NULL);
       printf("\r\n");
       print_list(head);
       del_node(&head,56);
       printf("\r\n");
       print_list(head);
       insert_node(&head->next,7,110);
       printf("\r\n");
       print_list(head);
       printf("\r\n");
       printf("insert==%d\r\n",insert_list_node(&head,0,876)->index);
       print_list(head);
       del_list_node(&head,5);
       printf("\r\n");
       print_list(head);
       printf("\r\n");
       list_node * lookup_node = lookup_list_node(&head,5);
       if(lookup_node)
       {
            printf("result==%d",lookup_node->index);
       }else{
            printf("not found!");
       }
       replace_list_node(&head,7,150);
       printf("\r\n");
       print_list(head);
       printf("\r\n");
       del_list(head);
       return 0;
}
