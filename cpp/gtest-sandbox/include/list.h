// list.h

#pragma once

#include <cstddef>

template <typename E>
class Node
{
 public:
  E x;
  Node *next;
  Node(E x0) : x(x0) {
    next = NULL;
  };
  ~Node() {
    //delete x;
  }
};

template <typename E>
class SLList 
{
 private:
  Node<E>* head;
  Node<E>* tail;
  size_t n = 0;
 public:
  E push(E x);
  E pop();
  size_t size();
};

template <typename E>
E SLList<E>::push(E x)
{
  Node<E> *u = new Node<E>(x);
  u->next = head;
  head = u;
  if (n == 0)
    tail = u;
  n++;
  return x;
}

template <typename E>
E SLList<E>::pop()
{
  if (n == 0)  return nullptr;
  E x = head->x;
  Node<E> *u = head;
  head = head->next;
  delete u;
  if (--n == 0) tail = NULL;
  return x;
}

template <typename E>
size_t SLList<E>::size()
{
  return n;
}
