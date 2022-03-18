*** Settings ***
Library                         SeleniumLibrary
Test Teardown                   Close Browser

*** Variables ***
${browser}                      Firefox
${vercelURL}                    https://demo.vercel.store/
${apparelCategory}              //*[@href="/search/apparel"]
${acceptCookiesButton}          //*[@class='Button_root__G_l9X mx-5']
${firstProduct}                 //*[@href="/product/next-js-enamel-mug"]
${addToCartButton}              //*[@aria-label="Add to Cart"]
${myCartTitle}                  //*[text()="My Cart"]
${productName}                  (//*[text()="Black Beanie"])[2]
${checkoutButton}               //*[@href="/checkout"]
${orderSummaryText}             //*[text()="Order Summary"]
${subtotalText}                 //*[text()='Subtotal']
${subtotalMyCartValue}          //li[contains(@class,'flex')]//span[text()="$80.00"]
${subtotalCheckoutValue}        (//*[@data-test='cart-price-value'])[1]
${taxesMyCartText}              //*[text()='Taxes']
${taxesMyCartValue}             //li[contains(@class,'flex')]//span[text()="Calculated at checkout"]
${taxCheckoutText}              //*[text()='Tax']
${taxCheckoutValue}             (//*[@data-test='cart-price-value'])[3]
${shippingText}                 //*[text()='Shipping']
${shippingMyCartValue}          //*[text()='FREE']
${shippingCheckoutValue}        //*[text()='--']
${totalText}                    //*[text()='Total']
${totalMyCartValue}             //div[contains(@class,'mb-2')]//span[text()="$80.00"]
${totalMyCheckoutValue}         //div[@data-test="cart-total"]//span[@class="cart-priceItem-value"]

*** Keywords ***
Open Vercel website
    Open Browser                            ${vercelURL}          ${browser} 
    Maximize Browser Window
    Click Element                           ${acceptCookiesButton}

Guess Choose Apparel Category
    Wait Until Page Contains Element        ${apparelCategory}
    Click Element                           ${apparelCategory} 

Click Black Beanie Hat
    Sleep                                   2
    Wait Until Page Contains Element        ${firstProduct}
    Click Element                           ${firstProduct}

Add Item to the Cart
    Wait Until Page Contains Element        ${addToCartButton}
    Click Element                           ${addToCartButton} 

See My Cart Information Correctly
    Sleep                                   2
    Wait Until Page Contains Element        ${myCartTitle}
    Wait Until Page Contains Element        ${productName}
    Wait Until Page Contains Element        ${subtotalText}
    Element Text Should Be                  ${subtotalMyCartValue}          $80.00
    Wait Until Page Contains Element        ${taxesMyCartText}
    Element Text Should Be                  ${taxesMyCartValue}             Calculated at checkout
    Wait Until Page Contains Element        ${shippingText}
    Element Text Should Be                  ${shippingMyCartValue}          FREE
    Wait Until Page Contains Element        ${totalText}
    Element Text Should Be                  ${totalMyCartValue}             $80.00

Click Proceed to Checkout Button
    Wait Until Page Contains Element        ${checkoutButton}
    Click Element                           ${checkoutButton} 

See Order Summary Correctly
    Sleep                                   2
    Wait Until Page Contains Element        ${orderSummaryText}
    Wait Until Page Contains Element        ${subtotalText}
    Element Text Should Be                  ${subtotalCheckoutValue}        $80.00
    Wait Until Page Contains Element        ${taxCheckoutText}
    Element Text Should Be                  ${taxCheckoutValue}             $0.00
    Wait Until Page Contains Element        ${shippingText}
    Element Text Should Be                  ${shippingCheckoutValue}        --
    Wait Until Page Contains Element        ${totalText}
    Element Text Should Be                  ${totalMyCheckoutValue}         $80.00

*** Test Cases ***
As a Guest, I want to Checkout a Cart and Shows Correct Information
    Given Open Vercel website
    When Guess Choose Apparel Category
    And Click Black Beanie Hat
    And Add Item to the Cart
    And See My Cart Information Correctly
    And Click Proceed to Checkout Button
    Then See Order Summary Correctly