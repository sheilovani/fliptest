*** Settings ***
Library                         SeleniumLibrary
# Test Teardown                   Close Browser

*** Variables ***
${browser}                      Firefox
${vercelURL}                    https://demo.vercel.store/
${menuButton}                   //*[@class="UserNav_avatarButton__9exMf"]
${emailField}                   (//*[@class="Input_root__eG6Wl"])[1]
${passwordField}                (//*[@class="Input_root__eG6Wl"])[2]                
${loginButton}                  //*[@class="Button_root__G_l9X Button_slim__WmpZF"]
${apparelCategory}              //*[@href="/search/apparel"]
${acceptCookiesButton}          //*[@class='Button_root__G_l9X mx-5']
${LightweightJacket}            //*[@href="/product/lightweight-jacket"]
${addToCartButton}              //*[@aria-label="Add to Cart"]
${myCartTitle}                  //*[text()="My Cart"]
${productName}                  (//*[text()="Lightweight Jacket"])[2]
${addQuantityButton}            (//*[@class="Quantity_actions__C9fVt"])[3]
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
${closeButton}                  //*[@class="ml-2 text-accent-7 text-sm "]
${searchField}                  (//*[@class="Searchbar_input__NfaB1"])[1)]
${searchIcon}                   (//*[@class="Searchbar_icon__fajpH"])[1)]
${firstProduct}                 //*[@href="/product/next-js-enamel-mug"]
${continueButton}               checkout-shipping-continue
${placeOrderButton}             checkout-payment-continue
${CCnumberField}                (//*[@class='form-input optimizedCheckout-form-input has-icon'])[1]
${expirationField}              (//*[@class='form-input optimizedCheckout-form-input'])[1]
${CVVField}                     (//*[@class='form-input optimizedCheckout-form-input has-icon'])[2]
${nameOnCardField}              (//*[@class='form-input optimizedCheckout-form-input'])[2]
${orderConfirmation}            //*[@class='optimizedCheckout-headingPrimary']

*** Keywords ***
Open Vercel website
    Open Browser                            ${vercelURL}                    ${browser} 
    Maximize Browser Window
    Click Element                           ${acceptCookiesButton}

Click Menu Button
    Click Element                           ${menuButton}

Login With Valid Email
    Wait Until Page Contains Element        ${emailField}
    Input Text                              ${emailField}                   alliwantisbugfree@gmail.com

Login With Valid Password
    Wait Until Page Contains Element        ${passwordField}
    Input Password                          ${passwordField}                Sheila123.,

Click Login Button
    Click Button                            ${loginButton}

Login Successfully
    Wait Until Page Contains Element        ${apparelCategory}

User Choose Lightweight Jacket
    Sleep                                   4
    Wait Until Page Contains Element        ${LightweightJacket}
    Click Element                           ${LightweightJacket} 

Add to Cart the Item
    Scroll Page To Location
    [Arguments]     ${x_location}    ${y_location}
    Execute JavaScript                      window.scrollTo(${x_location},${y_location})
    Click Element                           ${addToCartButton} 

See My Cart Page
    Sleep                                   2
    Wait Until Page Contains Element        ${myCartTitle}
    Wait Until Page Contains Element        ${productName}

Add the Quantity Become 2 Pieces
    Wait Until Page Contains Element        ${addQuantityButton}
    Click Element                           ${addQuantityButton}

Close My Cart page
    Wait Until Page Contains Element        ${closeButton}
    Click Element                           ${closeButton}

Search For Joggers
    Wait Until Page Contains Element        ${searchField}
    Click Element                           ${searchField}
    Input Text                              ${searchField}                    joggers
    Sleep                                   2
    Click Element                           ${searchIcon}

Choose Any Product
    Sleep                                   2
    Wait Until Page Contains Element        ${firstProduct}
    Click Element                           ${firstProduct}

Click Proceed to Checkout Button
    Wait Until Page Contains Element        ${checkoutButton}
    Click Element                           ${checkoutButton} 

See Order Summary Correctly
    Sleep                                   2
    Wait Until Page Contains Element        ${orderSummaryText}
    Wait Until Page Contains Element        ${subtotalText}
    Element Text Should Be                  ${subtotalCheckoutValue}          $80.00
    Wait Until Page Contains Element        ${taxCheckoutText}
    Element Text Should Be                  ${taxCheckoutValue}               $0.00
    Wait Until Page Contains Element        ${shippingText}
    Element Text Should Be                  ${shippingCheckoutValue}          --
    Wait Until Page Contains Element        ${totalText}
    Element Text Should Be                  ${totalMyCheckoutValue}           $80.00
 
Click Continue Button on Shipping Section
    Scroll Element Into View                ${continueButton}
    Wait Until Element is visible           ${continueButton}                 timeout=5s
    Set Focus To Element                    ${continueButton}
    Click Element                           ${continueButton}

Input My Credit Card Information
    Scroll Element Into View                ${placeOrderButton}
    Wait Until Element is visible           ${placeOrderButton}               timeout=5s
    Set Focus To Element                    ${CCnumberField}
    Click Element                           ${CCnumberField}
    Input Text                              ${CCnumberField}                  4111 1111 1111 1111
    Wait Until Page Contains Element        ${expirationField}
    Click Element                           ${expirationField}
    Input Text                              ${expirationField}                09 / 24
    Wait Until Page Contains Element        ${nameOnCardField}
    Click Element                           ${nameOnCardField}
    Input Text                              ${nameOnCardField}                Sheila Yovani
    Wait Until Page Contains Element        ${CVVField}
    Click Element                           ${CVVField}
    Input Text                              ${CVVField}                       999

Click Place Order Button
    Wait Until Page Contains Element        ${placeOrderButton}
    Click Element                           ${placeOrderButton} 

Order Confirm Successfully
    Sleep                                   7
    Wait Until Page Contains Element        ${orderConfirmation}
    Element Text Should Be                  ${orderConfirmation}              Thank you Sheila!


*** Test Cases ***
As a Login User, I Want to Login Successfully
    Given Open Vercel website
    When Click Menu Button
    And Login With Valid Email
    And Login With Valid Password
    And Click Login Button
    Then Login Successfully

As a Login User, I Want buy 2 Lightweight Jacket
    Given User Choose Lightweight Jacket
    And Add to Cart the Item            1201         749
    And See My Cart Page
    And Add the Quantity Become 2 Pieces
    Then Close My Cart page

As a Login User, I Want buy 1 Joggers
    Given Search For Joggers
    And Choose Any Product
    Then Click Proceed to Checkout Button

As a Login User, I Want to Process My Payment
    Given See My Order Summary Correctly
    When Click Continue Button on Shipping Section
    And Input My Credit Card Information
    And Click Place Order Button
    Then Order Confirm Successfully