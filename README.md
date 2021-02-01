<h1>REST API for a CRM interface</h1>

<ul>
  <li>Ruby 3.0</li>
  <li>Ruby on Rails 6.1.1</li>
</ul>

<h2>Authentication & Authorization</h2>

This project uses JWT to authenticate and authorize users to access the resources using <code>bcrypt</code> and <code>jwt</code> gems. For this to work is necessary to set the environment variable <code>JWT_SECRET</code>.

For authorization the gem <code>cancancan</code> is being used to manage permissions. The table <code>role</code> have been created to store the roles information and to make it easier to add new roles if necessary.

<h2>Development</h2>

For a faster environment setup we use <a href="https://www.vagrantup.com/">Vagrant</a>. The repository <a href="https://github.com/RedLincoln/vagrant_rails">vagrant_rails</a> provides a <code>Vagrantfile</code> with the technologies needed. Once the vagrant machine is running follow the next steps :

```
# in vagrant machine
# set JWT_SECRET enviroment variable (.bashrc)

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

<h2>Tests</h2>

<a href="https://rspec.info/">RSpec</a> is the test engine being used for testing. The tests are under the <code>spec</code> folder.

<h2>Endpoints</h2>

All enpoints starts with <code>/api/v1</code>

<hr>

<h3>User endpoints</h3>

<table>
  <tr>
    <th>Enpoint</th>
    <th>Functionality</th>
  </tr>
  <tr>
    <td>GET /auth/login</td>
    <td>Authentication, contains jwt token</td>
  </tr>
  <tr>
    <td>GET /customers</td>
    <td>get all customers of the database</td>
  </tr>
  <tr>  
    <td>GET /customers/:id</td>
    <td>get consumer detailed information</td>
  </tr>
  <tr>
    <td>POST /consumers</td>
    <td>Create new consumer</td>
  </tr>
  <tr>
    <td>PUT /consumers/:id</td>
    <td>Update existing consumer</td>
  </tr>
  <tr>
    <td>DELETE /consumers/:id</td>
    <td>Delete existing consumer</td>
  </tr>
</table>

<hr>
<h3>Admin endpoints</h3>

Admin users can use standard user endpoints as well as the following

<table>
  <tr>
    <th>Enpoint</th>
    <th>Functionality</th>
  </tr>
  <tr>
    <td>GET /users</td>
    <td>Get all users</td>
  </tr>
  <tr>
    <td>GET /users/:id</td>
    <td>Get user detailed information</td>
  </tr><tr>
    <td>POST /users</td>
    <td>Create new user</td>
  </tr><tr>
    <td>PUT /users/:id</td>
    <td>Update existing user</td>
  </tr><tr>
    <td>DELETE /users/:id</td>
    <td>Delete existing user</td>
  </tr>
</table>
