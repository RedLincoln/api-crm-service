<h1>REST API for a CRM interface</h1>

<br>
<br>
<h2>Table of content</h2>
1. <a href="#requirements">Requirements</a></br>
2. <a href="#auth">Authentication & Authorization</a></br>
3. <a href="#dev">Development</a></br>
4. <a href="#test">Tests</a></br>
5. <a href="#endpoints">Endpoints</a></br>
6. <a href="#fields">Resource fields</a></br>
7. <a href="#deployment">Deployment</a><br>
</br>

<h2 id="requirements">Requirements</h2>

<ul>
  <li>Ruby 2.6.6</li>
  <li>Ruby on Rails 6.1.1</li>
  <li>PostgreSQL</li>
</ul>

</br>
<br>
<h2 id="auth">Authentication & Authorization</h2>

This project is using <a href="https://auth0.com/">Auth0</a> to authenticate users. The endpoint <code>/auth/login</code> returns the token required to access the resources.

For Auth0 to work the next environment variables are required:

<ul>
  <li>AUTH0_DOMAIN: Auth0 account domain</li>
  <li>AUTH0_CLIENT_ID: Application client id</li>
  <li>AUTH0_CLIENT_SECRET: Application client secret</li>
  <li>AUTH0_CONNECTION: name of the connection (database) created in auth0</li>
</ul>

For authorization the gem <code>cancancan</code> is being used to manage permissions. The table <code>role</code> have been created to store the roles information and to make it easier to add new roles if necessary.

</br>
<br>
<h2 id="dev">Development</h2>

For a faster environment setup we use <a href="https://www.vagrantup.com/">Vagrant</a>. The repository <a href="https://github.com/RedLincoln/vagrant_rails">vagrant_rails</a> provides a <code>Vagrantfile</code> with the technologies needed. Once the vagrant machine is running follow the next steps :

```
# in vagrant machine

$ > cd /vagrant
$ > git clone https://github.com/RedLincoln/api-crm-service.git
$ > cd api-crm-service
$ > bundle install
$ > rails db:create
$ > rails db:migrate
$ > rails db:seed


# to run test
$ > rspec


# to start the server. http://localhost:3000
$ > rails s -b 0.0.0.0


```

</br>
<br>
<h2 id="test">Tests</h2>

<a href="https://rspec.info/">RSpec</a> is the test engine being used for testing. The tests are under the <code>spec</code> folder.

<br><br>

<h2 id="endpoints">Endpoints</h2>

All endpoints starts with <code>/api/v1</code>

<hr>
<br>
<h3>User endpoints</h3>

<table>
  <tr>
    <th>Endpoint</th>
    <th>Description</th>
    <th>Status code</th>
  </tr>
  <tr>
    <td>GET /auth/login</td>
    <td>Authentication, require </td>
    <td>
      200: body contains user info and access_token <br>
      401: Bad credentials
    </td>
  </tr>
  <tr>
    <td>GET /customers</td>
    <td>get all customers of the database</td>
    <td>
      200: body contains customer <br>
      401: Requires access_token
    </td>
  </tr>
  <tr>  
    <td>GET /customers/:id</td>
    <td>get customer information</td>
    <td>
      200: body contains Customer <br>
      401: Requires access_token <br>
      404: Customer not found
    </td>
  </tr>
  <tr>
    <td>POST /customers</td>
    <td>Create new customer</td>
    <td>
      201: Customer created, body contains customer <br>
      400: Missing required fields<br>
      401: Requires access_token
    </td>
  </tr>
  <tr>
    <td>PUT /customers/:id</td>
    <td>Update existing customer</td>
    <td>
      200: Customer updated, body contains customer <br>
      401: Requires access_token <br>
      404: Customer not found
    </td>
  </tr>
  <tr>
    <td>DELETE /customers/:id</td>
    <td>Delete existing customer</td>
    <td>
      200: Customer deleted <br>
      401: Requires access_token <br>
      404: Customer not found
    </td>
  </tr>
</table>

<hr>
<br>
<h3>Admin endpoints</h3>

Admin users can use standard user endpoints as well as the following

<table>
  <tr>
    <th>Endpoint</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>GET /users</td>
    <td>Get all users</td>
    <td>
      200: Body contains users <br>
      401: Bad access_token <br>
      401: Requires admin role
    </td>
  </tr>
  <tr>
    <td>GET /users/:id</td>
    <td>Get user detailed information</td>
    <td>
      200: Body contains user <br>
      401: Bad access_token <br>
      401: Requires admin role <br>
      404: User not found
    </td>
  </tr><tr>
    <td>POST /users</td>
    <td>Create new user</td>
    <td>
      201: User created, body contains user
      401: Bad access_token <br>
      401: Requires admin role <br>
      409: User already exists
    </td>
  </tr><tr>
    <td>PUT /users/:id</td>
    <td>Update existing user</td>
    <td>
      200: User updated, body contains user
      400: Field is already taken by another user
      401: Bad access_token <br>
      401: Requires admin role <br>
      404: User not found
    </td>
  </tr><tr>
    <td>DELETE /users/:id</td>
    <td>Delete existing user</td>
    <td>
      200: User deleted
      401: Bad access_token <br>
      401: Requires admin role <br>
      404: User not found
    </td>
  </tr>
</table>

<br>
<br>
<h2 id="fields">Resource fields</h2>

<br>
<h3>User</h3>

<table>
  <tr>
    <th>Name</th>
    <th>Value</th>
    <th>Required</th>
  </tr>
  <tr>
    <td>email</td>
    <td>String</td>
    <td>yes</td>
  </tr>
  <tr>
    <td>username</td>
    <td>String</td>
    <td>yes</td>
  </tr>
  <tr>
    <td>password</td>
    <td>String</td>
    <td>yes</td>
  </tr>
  <tr>
    <td>role</td>
    <td>{ 'standard', 'admin' }</td>
    <td>no - default 'standard' </td>
  </tr>

</table>

<br>
<h3>Customer</h3>

<table>
  <tr>
    <th>Name</th>
    <th>Value</th>
    <th>Required</th>
  </tr>
  <tr>
    <td>name</td>
    <td>String</td>
    <td>yes</td>
  </tr>
  <tr>
    <td>surname</td>
    <td>String</td>
    <td>yes</td>
  </tr>
  <tr>
    <td>photo</td>
    <td>File</td>
    <td>no</td>
  </tr>
</table>

<br>
<br>
<h2 id="deployment">Deployment</h2>

For continuous integration and continuous deployment we use Github Actions. The workflow is triggered by push or request pull to the main branch.
