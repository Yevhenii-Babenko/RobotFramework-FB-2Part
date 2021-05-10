*** Settings ***
Resource    resource.robot
Suite Setup

*** Test Cases ***
Sign Up With New Email Address
    ${inbox}    Create Email Address
    Open Browser To Home Page
    Go To SignUp Page

    #My code
    Input Robot Firstname
    Input Robot Lastname
    Input the first email    ${inbox.email_address}
    Input The Confirmation Email    ${inbox.email_address}
    Input Robot Password    ${TEST_PASSWORD}
    Section Birthday
    Select Month
    Select Year
    Select Robot Sex
    Submit Confirmation Button
    BuiltIn.Sleep    20s

    Wait Until Element Contains    //*[@id="content"]/div/div[1]/div/div[1]/div/div/div/div/div/div/div/div/div/div[1]/div/div[1]/span    Введіть код підтвердження timeout=120s
    Scroll Element Into View    //*[@id="content"]/div/div[1]/div/div[1]/div/div/div/div/div/div/div/div/div/div[2]/div/label
    Mouse Over     //*[@id="content"]/div/div[1]/div/div[1]/div/div/div/div/div/div/div/div/div/div[2]/div/label


    ${code}    Wait For Confirmation Code   ${inbox.id}
    Log To Console      ${code} extacted
    Input Confirmation Code     ${code}