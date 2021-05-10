*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    ./lib/MailSlurp.py    ${MAILSLURP_API_KEY}

#define our variables
*** Variables ***
${MAILSLURP_API_KEY}    PUT_YOUR_KEY_HERE
${SERVER}    www.facebook.com/
${BROWSER}    Chrome
${DELAY}    0
${PLAYGROUND URL}    https://${SERVER}/
${TEST_PASSWORD}    robRobs123!#!

*** Keywords ***
Create Email Address
    ${inbox}    Create Inbox
    [Return]    ${inbox}

Wait For Confirmation Code
    [Arguments]     ${inbox_id}
    ${email}    Wait For Latest Email   ${inbox_id}
    ${code}     Extract Email Content   ${email.body}
    [Return]    ${code}

Open Browser To Home Page
    #Open browser without modal windows
    ${options}=    Evaluate    sys.modules['selenium.webdriver.chrome.options'].Options()    sys
    Call Method    ${options}    add_argument    --disable-notifications
    ${driver}=    Create Webdriver    Chrome    options=${options}
	Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Go To    ${PLAYGROUND URL} 
#    Open Browser    ${PLAYGROUND URL}    ${BROWSER}
#    Maximize Browser Window
#    Set Selenium Speed    ${DELAY}
    Home Page Should Be Open

Home Page Should Be Open
    Title Should Be    Facebook — увійдіть або зареєструйтеся

SignUp Page Should Be Open
#    Wait Until Element Contains    //*[@data-test="sign-up-header-section"]//span   Sign Up
#    Wait Until Element Contains    //*[@data-testid="open-registration-form-button"]
    Wait Until Element Contains    //*[@id="facebook"]/body/div[3]/div[2]/div/div/div[1]    Зареєструватися

Go To SignUp Page
    Go To    ${PLAYGROUND URL}
    Home Page Should Be Open
#    Click Element   //a[@data-test="sign-in-create-account-link"]
    Click Element    //*[@data-testid="open-registration-form-button"]
    SignUp Page Should Be Open

#my code section
Input Robot Firstname
    Press Keys    //*[@name="firstname"]    Maverick

Input Robot Lastname
    Press Keys    //*[@name="lastname"]    Bell

Input The First Email
    [Arguments]    ${username}
    Press Keys    //*[@name="reg_email__"]    ${username}
    The Confirmation Email Should Be Present

Input The Confirmation Email
    [Arguments]    ${username}
    Press Keys    //*[@name="reg_email_confirmation__"]    ${username}

The Confirmation Email Should Be Present
    Wait Until Element Is Enabled    //*[@name="reg_email_confirmation__"]    timeout=15s  

Input Robot Password
    [Arguments]    ${password}
    Input Text    //*[@id="password_step_input"]    ${password}

Section Birthday
    Select From List By Value    //*[@id="day"]    21

Select Month
    Select From List By Label    //*[@id="month"]    жов
    
Select Year
    Select From List By Value    //*[@id="year"]    2001

Select Robot Sex
    Select Radio Button    sex    2

Submit Confirmation Button
    Scroll Element Into View    //*[@name="websubmit"]
    Click Button    //*[@name="websubmit"]


Input Confirmation Code
    [Arguments]    ${code}
    Input Text    //*[@type="text"]    ${code}
