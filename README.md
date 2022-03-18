# fliptest
### Setup
1. Install Homebrew on Mac
  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

2. install python3 and pip3
 - brew install python3
 - brew install pip3

2. install robot framework
 - pip3 install robotframework
 - pip3 install robotframework-seleniumlibrary
 - pip3 install robotframework-requests
 - pip3 install robotframework-jsonlibrary

3. install geckodriver
 - for mac
   please download https://github.com/mozilla/geckodriver/releases/download/v0.30.0/geckodriver-v0.30.0-macos.tar.gz 

### Running Features Test
 - robot -d report .\filename.robot
   ex : robot -d "report" ./chapter4_guest_uitest.robot