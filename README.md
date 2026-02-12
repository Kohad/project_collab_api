Project Collaboration API

    Ruby on Rails API demonstrating Role-Based Access Control (RBAC) with clean authorization architecture using policy classes.

📌 Tech Stack

    Ruby 3.2.2
    Rails 8 (API mode)
    SQLite

⚙️ Setup Instructions
    
    git clone <repo-url>
    cd project_collab_api
    bundle install
    rails db:create
    rails db:migrate
    rails db:seed
    rails server

Server runs on:

    http://localhost:3000


🔐 Authentication (Mocked)

    Authentication is mocked using request header:
        
        X-User-Id: <user_id>    

        Example:
        X-User-Id: 1

👥 User Roles

    admin

    manager

    member


📂 Membership Roles

    viewer → read only

    editor → can update project


🔒 Authorization Approach

    Authorization is implemented using Policy Classes located in:

        app/policies

    Controllers call:

        authorize!(record, :action)

        Policies decide permission logic.

        This keeps controllers clean and reusable.


🔐 🔹 IMPORTANT — COMMON HEADER

        For ALL requests (except unauthorized testing):

        Header:

            | Key          | Value            |
            | ------------ | ---------------- |
            | Content-Type | application/json |
            | X-User-Id    | <user_id>        |

        Seeded users:

            | Role    | ID |
            | ------- | -- |
            | Admin   | 1  |
            | Manager | 2  |
            | Member  | 3  |



📂 PROJECT ENDPOINTS

    Create Project

        POST /projects

        Who can access?

            ✔ Admin
            ✔ Manager

        Body (raw → JSON):
            {
            "project": {
                    "title": "My Project",
                    "description": "Demo"
                }
            }


    List Projects

        GET /projects

        Who can access?

            ✔ All roles


    Update Project

        PUT /projects/:id

        Who can access?

            ✔ Admin
            ✔ Owner (Manager)
            ✔ Editor member
        
        Body:

        {
        "project": {
            "title": "Updated Project Name"
            }
        }



    Delete Project

        DELETE /projects/:id

        Who can access?

            ✔ Admin
            ✔ Owner

        
👥 MEMBERSHIP ENDPOINTS

    Add Member

        POST /projects/:id/members

        Who can access?

            ✔ Admin
            ✔ Project Owner

        Body :
            {
            "membership": {
                "user_id": 3,
                "role": "viewer"
                }
            }

        OR

            {
            "membership": {
                "user_id": 3,
                "role": "editor"
                }
            }



    Remove Member

        DELETE /projects/:id/members/:user_id

        Who can access?

            ✔ Admin
            ✔ Project Owner


🚫 UNAUTHORIZED TEST

    Remove header:

        X-User-Id

    Expected:

        401 Unauthorized


🎯 Full Role Testing Matrix

    | Action         | Admin   | Manager  | Member Viewer  | Member Editor   |
    | -------------- | -----   | -------  | -------------  | -------------   |
    | Create Project | ✅     | ✅       | ❌             | ❌             |
    | List Projects  | ✅     | ✅       | ✅             | ✅             |
    | Update Project | ✅     | ✅       | ❌             | ✅             |
    | Delete Project | ✅     | ✅       | ❌             | ❌             |
    | Add Member     | ✅     | ✅       | ❌             | ❌             |
    | Remove Member  | ✅     | ✅       | ❌             | ❌             |



✅ RBAC Rules Summary

    Admin

        Full access

    Manager (Owner)

        Manage own projects

        Manage members

    Member

        Viewer → read

        Editor → update

    Unauthorized → 403 Forbidden



🧪 Seeded Users

    | ID | Email                                             |
    | -- | ------------------------------------------------- |
    | 1  | [admin@example.com](mailto:admin@example.com)     |
    | 2  | [manager@example.com](mailto:manager@example.com) |
    | 3  | [member@example.com](mailto:member@example.com)   |


📌 Assumptions

        Authentication is mocked

        No frontend

        JSON-only API


🏁 END