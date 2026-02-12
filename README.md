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


📌 API Endpoints

    Create Project

        POST /projects

        json :
            {
            "project": {
                    "title": "My Project",
                    "description": "Demo"
                }
            }


    List Projects

        GET /projects

    Update Project

        PUT /projects/:id

    Delete Project

        DELETE /projects/:id

    Add Member

        POST /projects/:id/members

        json :
            {
            "membership": {
                "user_id": 3,
                "role": "viewer"
                }
            }


    Remove Member

        DELETE /projects/:id/members/:user_id


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