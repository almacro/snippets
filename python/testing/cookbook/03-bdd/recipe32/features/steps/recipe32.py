from behave import *
from nose.tools import *
from cart import *

@given('an empty cart')
def step_impl(context):
    context.cart = ShoppingCart()

@then('looking up up the fifth item causes an error')
@raises(IndexError)
def step_impl(context):
    context.cart.item(5)

@then('looking up a negative price causes an error')
@raises(IndexError)
def step_impl(context):
    context.cart.price(-1)

@then('the price with no taxes is ${price:f}')
def step_impl(context, price):
    assert_equal(context.cart.total(0), 0)

@then('the price with taxes is ${price:f}')
def step_impl(context, price):
    assert_equal(context.cart.total(9.25), 0)

@when('I add a {item} for ${price:f}')
def step_impl(context, item, price):
    context.cart.add(item, price)

@when('I add another {item} for ${price:f}')
def step_impl(context, item, price):
    context.cart.add(item, price)

@then('the first item is a {item}')
def step_impl(context, item):
    eq_(context.cart.item(1), item)

@then('the price is ${price:f}')
def step_impl(context, price):
    eq_(context.cart.price(1), price)

@then('the cart has {count:d} items')
def step_impl(context, count):
    eq_( len(context.cart), count )

@then('the total cost with {tax:g}% tax is ${cost:f}')
def step_impl(context, tax, cost):
    assert_almost_equal(context.cart.total(tax), cost)

@when('I add a {item}')
def step_impl(context, item):
    if item == 'carton of milk':
        price = 2.50
    elif item == 'frozen pizza':
        price = 3.00
    context.cart.add(item, price)

@then('the second item is a {item}')
def step_impl(context, item):
    eq_(context.cart.item(2), item)

@then('the first price is ${price:f}')
def step_impl(context, price):
    eq_(context.cart.price(1), price)

@then('the second price is ${price:f}')
def step_impl(context, price):
    eq_(context.cart.price(2), price)

@then('the total cost with no taxes is ${cost:f}')
def step_impl(context, cost):
    assert_almost_equal(context.cart.total(0), cost)
