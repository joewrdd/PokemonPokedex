# 🔍 Pokédex Project

<div align="center">

![Pokédex Banner](frontend/assets/pokemon.png)

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Python-3.8+-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Django](https://img.shields.io/badge/Django-4.0+-092E20?style=for-the-badge&logo=django&logoColor=white)](https://www.djangoproject.com/)
[![PyTorch](https://img.shields.io/badge/PyTorch-1.9+-EE4C2C?style=for-the-badge&logo=pytorch&logoColor=white)](https://pytorch.org/)

</div>

A modern Pokédex application that combines Flutter for the frontend, Django for the backend, and PyTorch for image classification. Search for Pokémon, view detailed information, and identify Pokémon through image recognition.

## ✨ Features

- **🔍 Search Engine**: Find Pokémon by name with instant results
- **📊 Detailed Stats**: View comprehensive information about each Pokémon
- **🖼️ Image Classification**: Identify Pokémon using our trained AI model
- **🎨 Modern UI**: Beautiful, responsive interface with smooth animations
- **🔄 Real-time Data**: Powered by the OpenPokeAPI for accurate information

## 📱 Screenshots

<div align="center">
  <!-- Home & Search Screen -->
  <div style="display: flex; flex-direction: column; align-items: center;">
    <div style="flex: 2; padding: 10px;">
      <p><strong>Home & Search Screen</strong></p>
      <div style="display: flex; gap: 10px;">
        <img src="screenshots/1.png" width="250" alt="OnBoarding Light"/>
        <img src="screenshots/2.png" width="250" alt="OnBoarding Dark"/>
      </div>
    </div>
    <!-- Pokemon Details Screen -->
    <div style="display: flex; align-items: flex-start; margin-top: 20px;">
      <div style="flex: 2; padding: 10px;">
        <p><strong>Pokemon Details Screen</strong></p>
        <div style="display: flex; gap: 10px;">
          <img src="screenshots/3.png" width="250" alt="Login Light"/>
          <img src="screenshots/4.png" width="250" alt="Login Dark"/>
        </div>
      </div>
    </div>
    <!-- Pokemon List Screen -->
    <div style="display: flex; align-items: flex-start; margin-top: 20px;">
      <div style="flex: 2; padding: 10px;">
        <p><strong>Pokemon List Screen</strong></p>
        <div style="display: flex; gap: 10px;">
          <img src="screenshots/5.png" width="250" alt="SignUp Light"/> 
          <img src="screenshots/6.png" width="250" alt="SignUp Dark"/>
        </div>
      </div>
    </div>
    <!-- Pokemon Image Classification Screen -->
    <div style="display: flex; align-items: flex-start; margin-top: 20px;">
      <div style="flex: 2; padding: 10px;">
        <p><strong>Pokemon Image Classification Screen</strong></p>
        <div style="display: flex; gap:     10px;">
          <img src="screenshots/7.png" width="250" alt="Home Light"/>
          <img src="screenshots/8.png" width="250" alt="Home Dark"/>
        </div>
      </div>
    </div>
  </div>
</div>

## 🧠 AI Model

The image classification model is currently trained to recognize these Pokémon:

|  Blastoise   |  Charizard  | Butterfree  |  Dragonite  |    Gengar    |
| :----------: | :---------: | :---------: | :---------: | :----------: |
| **Gyarados** | **Pikachu** | **Rhyhorn** | **Slowbro** | **Venusaur** |

<details>
<summary>View model training visualization</summary>
<div align="center">
  <img src="model/training.png" alt="Model Training" width="600"/>
</div>
</details>

## 🚀 Getting Started

### Prerequisites

- Python 3.8+
- Node.js
- Flutter SDK
- Dart SDK

### Backend Setup

1. Navigate to the backend directory:

   ```bash
   cd backend/pokedex_model_api
   ```

2. Install the required Python packages:

   ```bash
   pip install -r requirements.txt
   ```

3. Apply the database migrations:

   ```bash
   python manage.py migrate
   ```

4. Start the Django development server:
   ```bash
   python manage.py runserver
   ```

### Frontend Setup

1. Navigate to the frontend directory:

   ```bash
   cd frontend
   ```

2. Install the required Dart packages:

   ```bash
   flutter pub get
   ```

3. Run the Flutter application:
   ```bash
   flutter run
   ```

## 📦 Project Structure

```
pokedex/
├── frontend/         # Flutter application
│   └── lib/          # Dart source code
├── backend/          # Django server
│   └── pokedex_model_api/  # API endpoints and model serving
└── model/            # PyTorch model for classification
    └── src/          # Model definition and training
```

## 🌟 Key Features Explained

### Image Classification

The application uses a deep learning model trained on Pokémon images to identify Pokémon from user-uploaded photos. The model achieves high accuracy through transfer learning and data augmentation techniques.

### Detailed Information

Each Pokémon's profile includes:

- Base stats (HP, Attack, Defense, etc.)
- Type information
- Abilities (including hidden abilities)
- Moves and learning methods
- Physical characteristics

## 🙏 Acknowledgements

- [OpenPokeAPI](https://pokeapi.co/) for providing a comprehensive Pokémon database
- The Flutter and Django communities for their excellent documentation and resources
- Contributors to the PyTorch ecosystem for enabling accessible deep learning

## 📄 License

This project is available under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">
  <p>Created With ❤️ by Joewrrdd</p>
</div>
