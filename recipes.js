const express = require('express'); 
const fs = require('fs'); 
const PORT = 3000; 
const app = express(); 

app.use(express.json()); 

//Function to read and parse JSON files 


function readJSONFile(filename) {
    const data = fs.readFileSync(filename, 'utf8');
    return JSON.parse(data);
  }
  

//Function to compare user groceries to recipe data 
var matchedRecipes = [];

function findMatchingRecipes(groceryItems, recipes) {
     // Iterate over each recipe
  for (var i = 0; i < recipes.length; i++) {
    var recipe = recipes[i];

    // Find matching ingredients between the recipe and grocery items
    var matchingIngredients = [];
    for (var j = 0; j < recipe.uniqueIngrediants.length; j++) {
      var ingredient = recipe.uniqueIngrediants[j];

      // Check if the ingredient exists in the grocery items
      for (var k = 0; k < groceryItems.length; k++) {
        var item = groceryItems[k];

        if (item.itemName.toLowerCase() === ingredient.toLowerCase()) {
          matchingIngredients.push(ingredient);
          break; // Exit the loop once a match is found
        }
      }
    }

    // Calculate the percentage of matching ingredients
    var matchPercentage = (matchingIngredients.length / recipe.uniqueIngrediants.length) * 100;

    // Add the recipe to the matchedRecipes if match percentage is >= 50%
    if (matchPercentage >= 50) {
      matchedRecipes.push(recipe);
    }
  }

  // Return the matched recipes
  return matchedRecipes;

}

app.post('/generateRecipes', (req, res) => {
    const { groceryItems } = req.body;

    // Read JSON files
    const breakfastRecipes = readJSONFile('breakfast.json');
    const lunchRecipes = readJSONFile('lunch.json');
    const dinnerRecipes = readJSONFile('dinner.json');
  
    // Find matching recipes
    const matchedBreakfast = findMatchingRecipes(groceryItems, breakfastRecipes);
    const matchedLunch = findMatchingRecipes(groceryItems, lunchRecipes);
    const matchedDinner = findMatchingRecipes(groceryItems, dinnerRecipes);
  
    res.json({
      breakfast: matchedBreakfast,
      lunch: matchedLunch,
      dinner: matchedDinner
    });
}); 


app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
  });
