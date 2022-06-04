*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     String

*** Variables ***
${BROWSER} =  Chrome
${URL} =   http://jupiter.cloud.planittesting.com

*** Keywords ***
Setup Chrome WebDriver Windows
   Set Environment Variable  webdriver.chrome.driver  ${EXECDIR}/chromedriver.exe

Open Browser and Navigate to Jupiter Toys
    open browser    ${URL}  ${BROWSER}
    maximize browser window
    wait until page contains element    ${page_Logo}