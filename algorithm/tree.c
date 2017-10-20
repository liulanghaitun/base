#include <stdio.h>
#include <stdlib.h>

typedef struct tree
{
    int data;
    struct tree *left;
    struct tree *right;
}tree_node;

tree_node* create_tree_node(int data)
{
    tree_node* message = malloc(sizeof(tree_node));
    if(message)
    {
        message->left = NULL;
        message->right = NULL;
        message->data = data;
    }
    return message;
}

void insert_tree_node(tree_node** current,int data)
{
    if(!*current)
    {
        *current = create_tree_node(data);
        return;
    }
    if((*current)->data > data)
    {
        insert_tree_node(&(*current)->left,data);
    }else
    {
        insert_tree_node(&(*current)->right,data);
    }
}

void delete_tree(tree_node* message)
{
    if(message)
    {
        delete_tree(message->left);
        delete_tree(message->right);
        printf("delete:%d\r\n",message->data);
        free(message);
    }
}

void print_pre_order(tree_node* message)
{
    if(message)
    {
        printf("%d ",message->data);
        print_pre_order(message->left);
        print_pre_order(message->right);
    }
}

void print_middle_order(tree_node* message)
{
    if(message)
    {
        print_middle_order(message->left);
        printf("%d ",message->data);
        print_middle_order(message->right);
    }
}

void print_post_value(tree_node* message)
{
    if(message)
    {
        print_post_value(message->left);
        print_post_value(message->right);
        printf("%d ",message->data);
    }
}

unsigned const int get_node_count(tree_node* root){ 
    if(root){ 
        return get_node_count(root->left)+get_node_count(root->right) +1; 
    } 
    return 0; 
}

void print_level_order(tree_node *root,const unsigned int nodeCount)
{
    tree_node *current;
    tree_node *queue_array[nodeCount];
    int front = -1,rear = -1;
    queue_array[++rear]=root;
    while(front != rear)
    {
        front=(front+1)%nodeCount;
        current=queue_array[front];
        printf("%d ",current->data);
        
        if(current->left)
        {
            rear=(rear+1)%nodeCount;
            queue_array[rear]=current->left;
        }
 
        if(current->right)
        {
            rear=(rear+1)%nodeCount;
            queue_array[rear]=current->right;
        }
    }
}

tree_node* find_tree_node(tree_node* root,int value)
{
    if(root)
    {
        if(root->data > value)
        {
              return find_tree_node(root->left,value);
        }else if(root->data < value){
              return find_tree_node(root->right,value);
        }
    }
    return root;
}

int main(void)
{
    tree_node* root = NULL;
    const int nodeValue[] = {10,49,24,69,35,4,13};
    int index = 0;
    for(; index<7; index++)
    {
        insert_tree_node(&root,nodeValue[index]);
    }
    print_pre_order(root);
    printf("\r\n");
    print_middle_order(root);
    printf("\r\n");
    print_post_value(root);
    printf("\r\n");
    print_level_order(root,get_node_count(root));
    printf("\r\n");
    printf("count==%d",get_node_count(root));
    printf("\r\n");
    if(find_tree_node(root,13))
    {
        printf("find success!");
    }else{
        printf("find failed!");
    }
    printf("\r\n");
    delete_tree(root);
    return 0;
}