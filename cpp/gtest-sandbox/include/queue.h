// queue.h

#pragma once

#include "list.h"

template <typename E>  // E is the element type
class Queue
{
 public:
  Queue();
  bool Enqueue(const E& element);
  E* Dequeue();  // returns NULL if the queue is empty
  size_t size() { return n; };
 private:
  size_t n = 0;
  Node<E> *head;
  Node<E> *tail;
};

template <typename E>
Queue<E>::Queue()
{
}

template <typename E>
bool Queue<E>::Enqueue(const E& element)
{
  Node<E> *u = new Node<E>(element);
  if (n == 0) {
    head = u;
  } else {
    tail->next = u;
  }
  tail = u;
  n++;
  return true;
}

template <typename E>
E* Queue<E>::Dequeue()
{
  if (n == 0)  return NULL;
  E* x = new E(head->x);
  Node<E> *u = head;
  head = head->next;
  delete u;
  if (--n == 0) tail = NULL;
  return x;
}
