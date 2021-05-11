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
    Input Personal Data
    Submit Confirmation Button
    BuiltIn.Sleep    80s
    Wait Until Element Is Visible    //*[@id="jsc_c_0"]    timeout=30s    error= The element didn't appear yet
    Mouse Over    //*[@id="jsc_c_0"]


    ${code}    Wait For Confirmation Code    ${inbox.id}
    Log To Console      ${code} extacted
    Input Confirmation Code     ${code}