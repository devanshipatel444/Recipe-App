const { createPool} = require('mysql2'); 
const express = require('express');
const bodyParser = require('body-paster');  

const app = express(); 
const pool  = createPool({
    host:"localhost", 
    user:"root", 
    password:"Mysadorableprincess1%",
    database:"recipe_app_db", 
    connectionLimit: 10,    
})
app.use(bodyParser.json());

app.post('/login', (req, res) => {
    const { username, password } = req.body; 

    //Query to check if user exists 
    const query = `SELECT * FROM user_info WHERE username = ? AND pass = ?`;
    pool.query(query, [username, password], (error, results) => {
        if (error) {
            res.status(500).send("Eroor ocurred during login process"); 
        }
        else if (results.lenght > 0) { //if user is found
            res.json({success: true, username: results[0].username }); 
        }

        else { //user not found
            res.json({ success:false, message: 'Username not found'}); 
        }
    });

});



app.listen(port, '0.0.0.0', () => {
    console.log(`Server running on http://0.0.0.0:${port}`);
  });



