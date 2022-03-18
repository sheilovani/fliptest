*** Settings ***
Library                         SeleniumLibrary
Test Teardown                   Close Browser

*** Variables ***
${browser}                      Firefox
${vercelURL}                    https://demo.vercel.store/
${shopAllCategory}              //*[@href="/search/shop-all"]
${sortHighToLowPrice}           //*[@href="/search/shop-all?sort=price-desc"]
${acceptCookiesButton}          //*[@class='Button_root__G_l9X mx-5']
${firstProduct}                 
${secondProduct}                

*** Keywords ***
Open Vercel website
    Open Browser                            ${vercelURL}          ${browser} 
    Maximize Browser Window
    Click Element                           ${acceptCookiesButton}

Guess Choose Shop All Category
    Wait Until Page Contains Element        ${shopAllCategory}
    Click Element                           ${shopAllCategory} 

Sort The Items by “Price: High to Low”
    Wait Until Page Contains Element        ${sortHighToLowPrice}
    Click Element                           ${sortHighToLowPrice} 

List Will be Sorted


*** Test Cases ***
As a Guest, I want to Sort Price from High to Low
    Given Open Vercel website
    When Guess Choose Shop All Category
    And Sort The Items by “Price: High to Low”
    Then List Will be Sorted