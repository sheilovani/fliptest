*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     JSONLibrary

*** Variables ***
${urlHost}                   https://gorest.co.in/
${endpointTodos}             public/v1/todos
${endpointComment}           public/v1/posts/1128/comments

*** Test Cases ***
API Test To Check Number of Items Data Are Correct According To The Metadata
    Create Session          my_session    ${urlHost}     verify=true
    ${param}=               Create Dictionary       status=completed        title=credo
    ${headers}=             Create Dictionary      Content-Type=application/json    charset=utf-8
    ${response}=            Get On Session    my_session    ${endpointTodos}    headers=${headers}       params=${param}
    Should Be Equal As Strings        ${response.status_code}     200
    ${totaldata}=           Set Variable        ${response.json()}[data]
    ${totalmeta}=           Set Variable        ${response.json()}[meta][pagination][total]
    ${numberOfItems}=       Get Length          ${totaldata}
    Log                     result = ${numberOfItems}, expected ${totalmeta}
    Should Be Equal         ${numberOfItems}          ${totalmeta}

API Test To Create New Comment For The Post ID 1128
    Create Session                      my_session    ${urlHost}     verify=true
    ${headers}=                         Create Dictionary      Content-Type=application/json    charset=utf-8
    ${token}=                           Create Dictionary      authorization=Bearer 63b59042678f281e11dde2cbf7c675508496182e9d5ee7b3e0e92719503d013d
    ${payload}=                         Create Dictionary      name=Sheila      email=sheila@mail.com       body=create comment
    ${response}=                        Post On Session    my_session    ${endpointComment}    headers=${token}    data=${payload}
    Should Be Equal As Strings          ${response.status_code}     201

    ${post_id}=                         Set Variable        ${response.json()}[data][post_id]
    Should Be Equal As Strings          ${response.json()}[data][post_id]     1128
    Log                                 result = ${post_id}, expected 1128
    ${result}=                          Evaluate            isinstance($post_id, int)
    Log                                 result = ${result}, expected int
    Should be True                      ${result}==True

    ${name}=                            Set Variable        ${response.json()}[data][name]
    Should Be Equal As Strings          ${response.json()}[data][name]        Sheila
    Log                                 result = ${name}, expected Sheila
    ${result}=                          Evaluate            isinstance($name, str)
    Log                                 result = ${result}, expected str
    Should be True                      ${result}==True

    ${email}=                           Set Variable        ${response.json()}[data][email]
    Should Be Equal As Strings          ${response.json()}[data][email]        sheila@mail.com  
    Log                                 result = ${email}, expected sheila@mail.com 
    ${result}=                          Evaluate            isinstance($email, str)
    Log                                 result = ${result}, expected str
    Should be True                      ${result}==True

    ${body}=                            Set Variable        ${response.json()}[data][body]
    Should Be Equal As Strings          ${response.json()}[data][body]        create comment  
    Log                                 result = ${email}, expected create comment
    ${result}=                          Evaluate            isinstance($body, str)
    Log                                 result = ${result}, expected str
    Should be True                      ${result}==True