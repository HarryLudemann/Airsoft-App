// Script contains conversions of english text to other languages
import 'package:Nguha/util/language_preference.dart';

LanguagePreferences langPreferences = LanguagePreferences();

String translate(text, [language = "English"]) {
  if (text == "English") return text;

  if (text == "Host") {
    if (language == "French") {
      return "Hôte";
    } else if (language == "Spanish") {
      return "Anfitrión";
    }
  }

  if (text == "Language:") {
    if (language == "French") {
      return "Langue:";
    } else if (language == "Spanish") {
      return "Idioma:";
    }
  }

  if (text == "Primary Color:") {
    if (language == "French") {
      return "Couleur primaire:";
    } else if (language == "Spanish") {
      return "Color primario:";
    }
  }

  if (text == "Display Name:") {
    if (language == "French") {
      return "Nom d'affichage:";
    } else if (language == "Spanish") {
      return "Nombre de pantalla:";
    }
  }

  if (text == "Settings") {
    if (language == "French") {
      return "Paramètres";
    } else if (language == "Spanish") {
      return "Ajustes";
    }
  }

  if (text == "How to Save Custom Games") {
    if (language == "French") {
      return "Comment sauvegarder des jeux personnalisés";
    } else if (language == "Spanish") {
      return "Cómo guardar juegos personalizados";
    }
  }

  if (text == "How to Host a Game") {
    if (language == "French") {
      return "Comment héberger un jeu";
    } else if (language == "Spanish") {
      return "Cómo anfitrión un juego";
    }
  }

  if (text == "How to Join a Game") {
    if (language == "French") {
      return "Comment rejoindre un jeu";
    } else if (language == "Spanish") {
      return "Cómo unirse a un juego";
    }
  }

  if (text == "Help") {
    if (language == "French") {
      return "Aide";
    } else if (language == "Spanish") {
      return "Ayuda";
    }
  }

  if (text == "Domination") {
    if (language == "French") {
      return "Domination";
    } else if (language == "Spanish") {
      return "Dominación";
    }
  }

  if (text == "Search and Destroy") {
    if (language == "French") {
      return "Chercher et détruire";
    } else if (language == "Spanish") {
      return "Buscar y destruir";
    }
  }

  if (text == "Games") {
    if (language == "French") {
      return "Jeux";
    } else if (language == "Spanish") {
      return "Juegos";
    }
  }

  if (text == "Host") {
    if (language == "French") {
      return "Hôte";
    } else if (language == "Spanish") {
      return "Anfitrión";
    }
  }

  if (text == "Join") {
    if (language == "French") {
      return "Rejoindre";
    } else if (language == "Spanish") {
      return "Unirse";
    }
  }

  if (text == "Enter code") {
    if (language == "French") {
      return "Entrer le code";
    } else if (language == "Spanish") {
      return "Introduzca el código";
    }
  }

  if (text == "Back") {
    if (language == "French") {
      return "Retour";
    } else if (language == "Spanish") {
      return "Atrás";
    }
  }

  if (text == "Start") {
    if (language == "French") {
      return "Démarrer";
    } else if (language == "Spanish") {
      return "Comenzar";
    }
  }

  if (text == "Sound") {
    if (language == "French") {
      return "Son";
    } else if (language == "Spanish") {
      return "Sonido";
    }
  }

  if (text == "Passcode Changes") {
    if (language == "French") {
      return "Changements de code";
    } else if (language == "Spanish") {
      return "Cambios de código";
    }
  }

  if (text == 'Wait Screen Time:') {
    if (language == "French") {
      return "Temps d'attente de l'écran:";
    } else if (language == "Spanish") {
      return "Tiempo de espera de la pantalla:";
    }
  }

  if (text == 'Cards To Remember:') {
    if (language == "French") {
      return "Cartes à mémoriser:";
    } else if (language == "Spanish") {
      return "Cartas para recordar:";
    }
  }

  if (text == "Plant/Defuse Attempts:") {
    if (language == "French") {
      return "Essais de plante/désamorcer:";
    } else if (language == "Spanish") {
      return "Intentos de plantar/desactivar:";
    }
  }

  if (text == "Bomb Explosion:") {
    if (language == "French") {
      return "Explosion de la bombe:";
    } else if (language == "Spanish") {
      return "Explosión de la bomba:";
    }
  }

  if (text == "Starting in") {
    if (language == "French") {
      return "Démarrer dans";
    } else if (language == "Spanish") {
      return "Comienza en";
    }
  }

  if (text == "Close") {
    if (language == "French") {
      return "Fermer";
    } else if (language == "Spanish") {
      return "Cerca";
    }
  }

  if (text ==
      "1. Plant/Defuse bomb by completing keycode.\n\n2. Finish keycode by selecting numbers in ascending order.\n\n3. Numbers disappear after first tile is selected.\n\n") {
    if (language == "French") {
      return "1. Plantez/Désamorcez la bombe en complétant le code clé.\n\n2. Terminez le code clé en sélectionnant les nombres dans l'ordre croissant.\n\n3. Les nombres disparaissent après la première tuile est sélectionnée.\n\n";
    } else if (language == "Spanish") {
      return "1. Plantar/Desactivar la bomba completando el código clave.\n\n2. Terminar el código clave seleccionando los números en orden ascendente.\n\n3. Los números desaparecen después de que la primera ficha es seleccionada.\n\n";
    }
  }

  if (text == "Help") {
    if (language == "French") {
      return "Aide";
    } else if (language == "Spanish") {
      return "Ayuda";
    }
  }

  if (text == "Search n Destroy") {
    if (language == "French") {
      return "Chercher et détruire";
    } else if (language == "Spanish") {
      return "Buscar y destruir";
    }
  }

  if (text == "How to Join Game") {
    if (language == "French") {
      return "Comment rejoindre un jeu";
    } else if (language == "Spanish") {
      return "Cómo unirse a un juego";
    }
  }

  if (text == "How to Host Game") {
    if (language == "French") {
      return "Comment héberger un jeu";
    } else if (language == "Spanish") {
      return "Cómo anfitrión un juego";
    }
  }

  if (text == "Domination") {
    if (language == "French") {
      return "Domination";
    } else if (language == "Spanish") {
      return "Dominación";
    }
  }

  if (text == "Waiting") {
    if (language == "French") {
      return "En attente";
    } else if (language == "Spanish") {
      return "Esperando";
    }
  }

  if (text == "Explosion") {
    if (language == "French") {
      return "Explosion";
    } else if (language == "Spanish") {
      return "Explosión";
    }
  }

  if (text == "Bomb Planted") {
    if (language == "French") {
      return "Bombe plantée";
    } else if (language == "Spanish") {
      return "Bomba plantada";
    }
  }

  if (text == "Bomb Defused") {
    if (language == "French") {
      return "Bombe désamorcée";
    } else if (language == "Spanish") {
      return "Bomba desactivada";
    }
  }

  if (text == "1 minute") {
    if (language == "French") {
      return "1 minute";
    } else if (language == "Spanish") {
      return "1 minuto";
    }
  }
  if (text == "2 minutes") {
    if (language == "French") {
      return "2 minutes";
    } else if (language == "Spanish") {
      return "2 minutos";
    }
  }

  if (text == "5 minutes") {
    if (language == "French") {
      return "5 minutes";
    } else if (language == "Spanish") {
      return "5 minutos";
    }
  }

  if (text == "15 minutes") {
    if (language == "French") {
      return "15 minutes";
    } else if (language == "Spanish") {
      return "15 minutos";
    }
  }

  if (text == "10 minutes") {
    if (language == "French") {
      return "10 minutes";
    } else if (language == "Spanish") {
      return "10 minutos";
    }
  }

  if (text == "10 seconds") {
    if (language == "French") {
      return "10 secondes";
    } else if (language == "Spanish") {
      return "10 segundos";
    }
  }

  if (text == "30 seconds") {
    if (language == "French") {
      return "30 secondes";
    } else if (language == "Spanish") {
      return "30 segundos";
    }
  }

  if (text == "45 seconds") {
    if (language == "French") {
      return "45 secondes";
    } else if (language == "Spanish") {
      return "45 segundos";
    }
  }

  if (text == "GO!") {
    if (language == "French") {
      return "GO!";
    } else if (language == "Spanish") {
      return "¡VA!";
    }
  }

  return text;
}
