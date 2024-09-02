const fs = require('fs'); 
const { Builder, By, Key, until } = require('selenium-webdriver');
const express = require("express"); 
const { google } = require("googleapis"); 
const app = express(); 
const path = require('path'); 






app.get("/", async(req, res) => {
    const auth = new google.auth.GoogleAuth({
        keyFile: "credentials.json", 
        scopes: "https://www.googleapis.com/auth/spreadsheets"
    }); 

    //Create client instance for auth 
    const client = await auth.getClient(); 

    //Create instance of Google Sheets API
    const googleSheets = google.sheets({version: "v4", auth: client}); 
    const spreadsheetId = "1sQ1Jasx1dJTEXBfpr_7VZncw2XItZK1NQnL6vpTwl-Y"; 

    async function fetchUrlsFromSheet(sheetName, googleSheets ) {
        const response = await googleSheets.spreadsheets.values.get({
            auth,
            spreadsheetId, 
            range: sheetName
        }); 
        return response.data.values.flat(); // return URLS as flat array 
    }

    
    async function scrapeRecipe(url) {
    
        let driver = await new Builder().forBrowser('chrome').build(); 
        try{
            await driver.get(url); 
            const title = await driver.findElement(By.css('h1')).getText(); 
            //find heading of ingrediants 
    
            //To get the ingrediants list =---> use XPath 
            //XPath --> selects elements based on the hierarchical relationship
            let ingredientsElements = await driver.findElements(By.xpath(
             
    
                "//ul[contains(@class, 'ingredient')]//li"
            ));
    
        
            //Extracting text from each list 
            let ingredients = []; 
            for(let element of ingredientsElements) {
                const ingredientText = await element.getText();
                ingredients.push(ingredientText); 
            }
            let filterArrayIngredients = []; 

            filterArrayIngredients = Array.from(new Set(ingredients)). filter((ingredient) => !ingredient.includes('optional'))
    
    
            //Creating the JSON object
           
            const recipeData = { 
                url: url, 
                title: title,
                ingredients: filterArrayIngredients
    
    
            }; 
            return recipeData; 
    
    
        } catch (error) {
            console.error(`Error scraping ${url}`, error)
        }finally {
            await driver.quit(); 
        }
    }  
    
    async function scrapeAllRecipes (urls, mealType) {
        const recipes = []; 
    
        //Loop through each URL and scrape the data 
        for(let url of urls) {
            const recipeData = await scrapeRecipe(url); 
            if (recipeData) {
                recipes.push(recipeData); 
            }
        }
    
        //Write to JSON file based on meal type 
        fs.writeFileSync(`${mealType.toLowerCase()}.json`, JSON.stringify(recipes, null, 2)); 
        console.log(`${mealType} recipes written to ${mealType.toLowerCase()}.json`);
    
    
    } 

    try {
        //const breakfastUrls = await fetchUrlsFromSheet("Breakfast", googleSheets);
        //console.log(breakfastUrls); 
        //const lunchUrls = await fetchUrlsFromSheet("Lunch", googleSheets);
        const dinnerUrls = await fetchUrlsFromSheet("Dinner", googleSheets);

        // Scrape recipes and write to JSON files
        //await scrapeAllRecipes(breakfastUrls, "Breakfast");
        //await scrapeAllRecipes(lunchUrls, "Lunch");
        await scrapeAllRecipes(dinnerUrls, "Dinner");
        res.send("Recipes scraped and written to JSON files."); 

    }  catch (error) {
        console.error("Error processing request:", error);
        res.status(500).send("An error occurred.");
    }

})

const PORT = 3000; 
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));


