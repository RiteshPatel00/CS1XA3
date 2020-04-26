
# CS 1XA3 Project03 - <MyMacId>
## Usage
Make sure conda environment is installed with django

Make sure to also run migrations whether running locally or on the mac1xa3.ca server

This project can run locally with:

`python manage.py runserver localhost:8000`

With the url:
`http://localhost:8000/e/pater16/`


If on mac1xa3.ca, to serve static assets makes sure the public_html directory contains the static folder, then the server can be ran with my local host port, makes sure you are in the directory with the `manage.py` file and run:

`python manage.py runserver localhost:10079`

With the url:
`https:mac1xa3.ca/e/pater16/`

## Objective 01
Description:
- feature allows client to make account, by creating a `User` object
- To use feature click on `Create Account` button which will take you to a page where you can enter a user name and password
- Exception: If user already exists then it will not be created twice

## Objective 02
Description:
- objective is achieved by implementing user's interests in order to create an UserInfo object

## Objective 03
Description:
- this feature now allows the currently logged in user to change his/her password
- Also allows user to add in their basic information which includes employment, location, birthday and interests
- To use feature click on top right corner avatar
- Exceptions: If current password is written incorrectly, an error will prompt, also if date is not written in correct format of YYYY-MM-DD since it is implemented using python's `datetime` library


## Objective 04
Description:
- In this objective, I show the other users who have made an account
- In order to see the people, click the person icon beside the `Logout` button in the top left


## Objective 05
Description:
- this feature allows users to send friend requests by clicking on a friend request
- If the user who got the request accepts, they will no longer appear on the senders list of people since they are now friends


## Objective 06
Description:
- this feature simply allows us to accept or reject friend requests


## Objective 07
Description:
- Now clicking on the messages icon besides the person icon will render a page with all of the friend requests that we accepted


## Objective 08
Description:
- Posts are made when clicking on the messages icon by writing out what ever you want
- Posts can be viewed underneath where you write them


## Objective 09
Description:
- Now we can display the post list by editing the messages.djhtml and properly implementing the messages_view in `
views.py`
-Users friends will see their posts and vice-versa

## Objective 10
Description:
- Here I give the functionality of being able to like posts
- Posts can only be liked by one person once, to avoid spamming the like button 
- Currently there is no implementation to unlike or dislike posts 

## Objective 11
Description:
- Not implemented


