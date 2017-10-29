#include <stdlib.h>
#include <stdio.h>

#define height(avl_node) (avl_node ? avl_node->avl_height : -1)
#define max(left,right) (left > right ? left : right)

typedef struct avl_tree_node {
    int avl_data;
    struct avl_tree_node *avl_left;
    struct avl_tree_node *avl_right;
    struct avl_tree_node *avl_parent;
    int avl_height;
} avl_tree_node_t;

avl_tree_node_t* avl_find_node(avl_tree_node_t *root, int data)
{
    if (root == NULL) return NULL;
    if (data < root->avl_data)
        return avl_find_node(root->avl_left, data);
    else if (data > root->avl_data)
        return avl_find_node(root->avl_right, data);
    else
        return root;
}

void avl_update_height(avl_tree_node_t *root)
{
    root->avl_height = 1 + max(height(root->avl_left), height(root->avl_right));
}

avl_tree_node_t* avl_rotate_right(avl_tree_node_t *root)
{
    avl_tree_node_t *left_root = root->avl_left;
    if (root->avl_parent) {
        if (root->avl_parent->avl_left == root) root->avl_parent->avl_left = left_root;
        else root->avl_parent->avl_right = left_root;
    }
    left_root->avl_parent = root->avl_parent;
    root->avl_left = left_root->avl_right;
    if (root->avl_left) root->avl_left->avl_parent = root;
    left_root->avl_right = root;
    root->avl_parent = left_root;

    avl_update_height(root);
    avl_update_height(left_root);
    return left_root;
}

avl_tree_node_t* avl_rotate_left(avl_tree_node_t *root)
{
    avl_tree_node_t *right_root = root->avl_right;
    if (root->avl_parent) {
        if (root->avl_parent->avl_right == root) root->avl_parent->avl_right = right_root;
        else root->avl_parent->avl_left = right_root;
    }
    right_root->avl_parent = root->avl_parent;
    root->avl_right = right_root->avl_left;
    if (root->avl_right) root->avl_right->avl_parent = root;
    right_root->avl_left = root;
    root->avl_parent = right_root;

    avl_update_height(root);
    avl_update_height(right_root);
    return right_root;
}

avl_tree_node_t* avl_create_node(int data, avl_tree_node_t *parent)
{
    avl_tree_node_t *avl_node = (avl_tree_node_t *)malloc(sizeof(avl_tree_node_t));
    if(avl_node) {
        avl_node->avl_data = data;
        avl_node->avl_parent = parent;
        avl_node->avl_height = 0;
        avl_node->avl_left = NULL;
        avl_node->avl_right = NULL;
    }
    return avl_node;
}

avl_tree_node_t* avl_balance(avl_tree_node_t *root)
{
    if (height(root->avl_left) - height(root->avl_right) > 1) {
        if (height(root->avl_left->avl_left) > height(root->avl_left->avl_right)) {
            root = avl_rotate_right(root);
        } else {
            avl_rotate_left(root->avl_left);
            root = avl_rotate_right(root);
        }
    } else if (height(root->avl_right) - height(root->avl_left) > 1) {
        if (height(root->avl_right->avl_right) > height(root->avl_right->avl_left)) {
            root = avl_rotate_left(root);
        } else {
            avl_rotate_right(root->avl_right);
            root = avl_rotate_left(root);
        }
    }
    return root;
}

avl_tree_node_t* avl_find_max_node(avl_tree_node_t* root)
{
    if(root)
    {
        if(root->avl_right)
        {
            return avl_find_max_node(root->avl_right);
        }
    }
    return root;
}

avl_tree_node_t* avl_find_min_node(avl_tree_node_t* root)
{
    if(root)
    {
        if(root->avl_left)
        {
            return avl_find_min_node(root->avl_left);
        }
    }
    return root;
}

avl_tree_node_t* avl_delete_node(avl_tree_node_t* root, int data)
{
    avl_tree_node_t* current = NULL;
    if(root)
    {
        if(data < root->avl_data)
        {
            root->avl_left = avl_delete_node(root->avl_left,data);
        }else if(data > root->avl_data)
        {
            root->avl_right = avl_delete_node(root->avl_right,data);
        }else{
            if(root->avl_right)
            {
                current = avl_find_min_node(root->avl_right);
                root->avl_data = current->avl_data;
                root->avl_right = avl_delete_node(root->avl_right,root->avl_data);
            }else if(root->avl_left)
            {
                current = avl_find_max_node(root->avl_left);
                root->avl_data = current->avl_data;
                root->avl_left = avl_delete_node(root->avl_left,root->avl_data);
            }else{
                free(root);
                root = NULL;
                return NULL;
            }
        }
       avl_update_height(root);
       root = avl_balance(root); 
    }
    return root;
}

avl_tree_node_t* avl_insert_node(avl_tree_node_t* root, int data)
{
    avl_tree_node_t* current = root;
    if(current) {
        while (current->avl_data != data) {
            if (data < current->avl_data) {
                if (current->avl_left) current = current->avl_left;
                else {
                    current->avl_left = avl_create_node(data, current);
                    current = current->avl_left;
                }
            } else if (data > current->avl_data) {
                if (current->avl_right) current = current->avl_right;
                else {
                    current->avl_right = avl_create_node(data, current);
                    current = current->avl_right;
                }
            } else return root;
        }

        do {
            current  = current->avl_parent;
            avl_update_height(current);
            current = avl_balance(current);
        } while (current->avl_parent);
    }else{
        current = avl_create_node(data,NULL);
    }
    return current;
}

void avl_print_tree_indent(avl_tree_node_t *node, int indent)
{
    int ix;
    for (ix = 0; ix < indent; ix++) printf(" ");
    if (!node) printf("Empty child\n");
    else {
        printf("node: %d; height: %d\n", node->avl_data, node->avl_height);
        avl_print_tree_indent(node->avl_left, indent + 4);
        avl_print_tree_indent(node->avl_right, indent + 4);
    }
}

void avl_print_tree(avl_tree_node_t* avl_tree, int data , int direction)
{
    if(avl_tree) {
        if(direction==0)
            printf("%2d is root\n", avl_tree->avl_data);
        else
            printf("%2d is %2d's %6s child\n", avl_tree->avl_data, data, direction==1?"right" : "left");

        avl_print_tree(avl_tree->avl_left, avl_tree->avl_data, -1);
        avl_print_tree(avl_tree->avl_right,avl_tree->avl_data,  1);
    }
}

void avl_print_order(avl_tree_node_t *node)
{
    if(node) {
        avl_print_order(node->avl_left);
        printf("(%d,%d) ",node->avl_data,node->avl_height);
        avl_print_order(node->avl_right);
    }
}

void avl_delete_tree(avl_tree_node_t* root)
{
    if(root) {
        avl_delete_tree(root->avl_left);
        avl_delete_tree(root->avl_right);
        free(root);
    }
}

int main(int argc, char *argv[])
{
    static int data[]= {3,2,1,4,5,6,7,16,15,14,13,12,11,10,8,9};
    avl_tree_node_t* root = NULL;
    int index = 0;
    for(; index < sizeof(data)/sizeof(data[0]); index++) {
        root = avl_insert_node(root,data[index]);
    }
    avl_print_tree_indent(root, 0);
    avl_print_order(root);
    printf("\r\n");
    avl_print_tree(root,root->avl_data,0);
    avl_tree_node_t* find_node = avl_find_node(root,12);
    printf(find_node?"find success!\r\n":"find failed!\r\n");
    printf("max_value==%d\r\n",avl_find_max_node(root)->avl_data);
    printf("min_value==%d\r\n",avl_find_min_node(root)->avl_data);
    avl_delete_node(root,8);
    avl_print_order(root);
    printf("\r\n");
    avl_print_tree(root,root->avl_data,0);
    printf("\r\n");
    avl_delete_tree(root);
    return 0;
}
