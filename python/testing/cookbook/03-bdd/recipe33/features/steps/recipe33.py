from behave import *
from should_dsl import should, should_not
from cart import *

@given('an empty cart')
def step_impl(context):
    context.cart = ShoppingCart()

@then('looking up up the fifth item causes an error')
def step_impl(context):
    (lambda: context.cart.item(5)) |should| throw(IndexError)

@then('looking up a negative price causes an error')
def step_impl(context):
    (lambda: context.cart.price(-1)) |should| throw(IndexError)

@then('the price with no taxes is ${price:f}')
def step_impl(context, price):
    context.cart.total(0) |should| equal_to(price)

@then('the price with taxes is ${price:f}')
def step_impl(context, price):
    context.cart.total(9.25) |should| equal_to(price)

@when('I add a {item} for ${price:f}')
def step_impl(context, item, price):
    context.cart.add(item, price)

@when('I add another {item} for ${price:f}')
def step_impl(context, item, price):
    context.cart.add(item, price)

@then('the first item is a {item}')
def step_impl(context, item):
    context.cart.item(1) |should| equal_to(item)

@then('the price is ${price:f}')
def step_impl(context, price):
    context.cart.price(1) |should| equal_to(price)

@then('the cart has {count:d} items')
def step_impl(context, count):
    len(context.cart) |should| equal_to(count)

@then('the total cost with {tax:g}% tax is ${cost:f}')
def step_impl(context, tax, cost):
    context.cart.total(tax) |should| close_to(cost, delta=0.01)

@when('I add a {item}')
def step_impl(context, item):
    if item == 'carton of milk':
        price = 2.50
    elif item == 'frozen pizza':
        price = 3.00
    context.cart.add(item, price)

@then('the second item is a {item}')
def step_impl(context, item):
    context.cart.item(2) |should| equal_to(item)

@then('the first price is ${price:f}')
def step_impl(context, price):
    context.cart.price(1) |should| equal_to(price)

@then('the second price is ${price:f}')
def step_impl(context, price):
    context.cart.price(2) |should| equal_to(price)

@then('the total cost with no taxes is ${cost:f}')
def step_impl(context, cost):
    context.cart.total(0) |should| close_to(cost, delta=0.01)
