<h1>REST API for a CRM interface</h1>


<ul>
  <li>Ruby 3.0</li>
  <li>Ruby on Rails 6.1.1</li>
</ul>

<h2>Development</h2>

For a faster enviroment setup we use <a href="https://www.vagrantup.com/">Vagrant</a>. The repository <a href="https://github.com/RedLincoln/vagrant_rails">vagrant_rails</a> provides a <code>Vagrantfile</code> with the tecnologies needed.


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

