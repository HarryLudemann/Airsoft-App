// Script contains conversions of english text to other languages

// key is english, value is french
final Map<String, String> frenchDict = {
  "Host: ": "Hôte: ",
  "Join: ": "Rejoindre: ",
  "Host": "Hôte",
  "Join": "Rejoindre",
  "GO!": "VA!",
  "Back": "Retour",
  "45 seconds": "45 secondes",
  "30 seconds": "30 secondes",
  "10 seconds": "10 secondes",
  "10 minutes": "10 minutes",
  "15 minutes": "15 minutes",
  "5 minutes": "5 minutes",
  "2 minutes": "2 minutes",
  "1 minute": "1 minute",
  "Bomb Defused": "Bombe désamorcée",
  "Bomb Planted": "Bombe plantée",
  "Explosion": "Explosion",
  "Waiting": "En attente",
  "Domination": "Domination",
  "How to Join Game": "Comment rejoindre un jeu",
  "How to Host Game": "Comment héberger un jeu",
  "Search n Destroy": "Chercher et détruire",
  "Search and Destroy": "Chercher et détruire",
  "Help": "Aide",
  "Close": "Fermer",
  "Starting in": "Début dans",
  "Bomb Explosion:": "Explosion de la bombe:",
  "Bomb Defused:": "Bombe désamorcée:",
  "Bomb Explosion:": "Explosion de la bombe:",
  "Plant/Defuse Attempts:": "Essais de plantage/désactivation:",
  "Plant/Defuse Attempts:": "Intentos de plantar/desactivar:",
  "Cards To Remember:": "Cartas a recordar:",
  "Wait Screen Time:": "Tiempo de espera en pantalla:",
  "Passcode Changes:": "Cambios de código de acceso:",
  "Sound": "Sonido",
  "Start": "Démarrer",
  "Enter code": "Entrer le code",
  "Back": "Retour",
  "Games": "Jeux",
  "Settings": "Paramètres",
  "Display Name:": "Nom d'affichage:",
  "Primary Color:": "Couleur primaire:",
  "Language:": "Langue:",
  "Settings": "Paramètres",
  "Languages": "Langues",
  "Language:": "Langue:",
};

// key is english, value is spanish
final Map<String, String> spanishDict = {
  "Host: ": "Anfitrión: ",
  "Join: ": "Unirse: ",
  "Host": "Anfitrión",
  "Join": "Unirse",
  "GO!": "¡VA!",
  "Back": "Volver",
  "45 seconds": "45 segundos",
  "30 seconds": "30 segundos",
  "10 seconds": "10 segundos",
  "10 minutes": "10 minutos",
  "15 minutes": "15 minutos",
  "5 minutes": "5 minutos",
  "2 minutes": "2 minutos",
  "1 minute": "1 minuto",
  "Bomb Defused": "Bomba desactivada",
  "Bomb Planted": "Bomba plantada",
  "Explosion": "Explosión",
  "Waiting": "Esperando",
  "Domination": "Dominación",
  "How to Join Game": "Cómo unirse a un juego",
  "How to Host Game": "Cómo anfitrión un juego",
  "Search n Destroy": "Buscar y destruir",
  "Search and Destroy": "Buscar y destruir",
  "Help": "Ayuda",
  "Close": "Cerrar",
  "Starting in": "Comienza en",
  "Bomb Explosion:": "Explosión de la bomba:",
  "Bomb Defused:": "Bomba desactivada:",
  "Bomb Explosion:": "Explosión de la bomba:",
  "Plant/Defuse Attempts:": "Intentos de plantar/desactivar:",
  "Plant/Defuse Attempts:": "Intentos de plantar/desactivar:",
  "Cards To Remember:": "Cartas a recordar:",
  "Wait Screen Time:": "Tiempo de espera en pantalla:",
  "Passcode Changes:": "Cambios de código de acceso:",
  "Sound": "Sonido",
  "Start": "Empezar",
  "Enter code": "Ingresar el código",
  "Back": "Atrás",
  "Games": "Juegos",
  "Settings": "Configuración",
  "Display Name:": "Nombre de pantalla:",
  "Primary Color:": "Color primario:",
  "Language:": "Idioma:",
  "Settings": "Configuración",
  "Languages": "Idiomas",
  "Language:": "Idioma:",
};

// key is english, value is russian
final Map<String, String> russianDict = {
  "Host: ": "Хост: ",
  "Join: ": "Присоединиться: ",
  "Host": "Хост",
  "Join": "Присоединиться",
  "GO!": "ВАЛЕ!",
  "Back": "Назад",
  "45 seconds": "45 секунд",
  "30 seconds": "30 секунд",
  "10 seconds": "10 секунд",
  "10 minutes": "10 минут",
  "15 minutes": "15 минут",
  "5 minutes": "5 минут",
  "2 minutes": "2 минуты",
  "1 minute": "1 минута",
  "Bomb Defused": "Бомба открыта",
  "Bomb Planted": "Бомба установлена",
  "Explosion": "Взрыв",
  "Waiting": "Ожидание",
  "Domination": "Доминация",
  "How to Join Game": "Как присоединиться к игре",
  "How to Host Game": "Как проводить игру",
  "Search n Destroy": "Поиск и уничтожение",
  "Search and Destroy": "Поиск и уничтожение",
  "Help": "Помощь",
  "Close": "Закрыть",
  "Starting in": "Начинается через",
  "Bomb Explosion:": "Взрыв бомбы:",
  "Bomb Defused:": "Бомба открыта:",
  "Bomb Explosion:": "Взрыв бомбы:",
  "Plant/Defuse Attempts:": "Попытки установить/открыть бомбу:",
  "Plant/Defuse Attempts:": "Попытки установить/открыть бомбу:",
  "Cards To Remember:": "Карты для запоминания:",
  "Wait Screen Time:": "Время ожидания на экране:",
  "Passcode Changes:": "Изменения пароля:",
  "Sound": "Звук",
  "Start": "Начать",
  "Enter code": "Введите код",
  "Back": "Назад",
  "Games": "Игры",
  "Settings": "Настройки",
  "Display Name:": "Имя для отображения:",
  "Primary Color:": "Основной цвет:",
  "Language:": "Язык:",
  "Settings": "Настройки",
  "Languages": "Языки",
  "Language:": "Язык:",
};

// key is english, value is german
final Map<String, String> germanDict = {
  "Host: ": "Host: ",
  "Join: ": "Beitreten: ",
  "Host": "Host",
  "Join": "Beitreten",
  "GO!": "GO!",
  "Back": "Zurück",
  "45 seconds": "45 Sekunden",
  "30 seconds": "30 Sekunden",
  "10 seconds": "10 Sekunden",
  "10 minutes": "10 Minuten",
  "15 minutes": "15 Minuten",
  "5 minutes": "5 Minuten",
  "2 minutes": "2 Minuten",
  "1 minute": "1 Minute",
  "Bomb Defused": "Bombe entschärft",
  "Bomb Planted": "Bombe gepflanzt",
  "Explosion": "Explosion",
  "Waiting": "Warten",
  "Domination": "Dominanz",
  "How to Join Game": "Wie beitreten Sie einem Spiel",
  "How to Host Game": "Wie organisieren Sie ein Spiel",
  "Search n Destroy": "Suche und Zerstöre",
  "Search and Destroy": "Suche und Zerstöre",
  "Help": "Hilfe",
  "Close": "Schließen",
  "Starting in": "Startet in",
  "Bomb Explosion:": "Bombe explodiert:",
  "Bomb Defused:": "Bombe entschärft:",
  "Bomb Explosion:": "Bombe explodiert:",
  "Plant/Defuse Attempts:": "Versuche zu planten/entschärfen:",
  "Plant/Defuse Attempts:": "Versuche zu planten/entschärfen:",
  "Cards To Remember:": "Karten zum Merken:",
  "Wait Screen Time:": "Wartezeit auf dem Bildschirm:",
  "Passcode Changes:": "Passcode-Änderungen:",
  "Sound": "Sound",
  "Start": "Start",
  "Enter code": "Code eingeben",
  "Back": "Zurück",
  "Games": "Spiele",
  "Settings": "Einstellungen",
  "Display Name:": "Anzeigename:",
  "Primary Color:": "Primärer Farbton:",
  "Language:": "Sprache:",
  "Settings": "Einstellungen",
  "Languages": "Sprachen",
  "Language:": "Sprache:",
};

String translate(text, [language = "English"]) {
  if (language == "English") return text;
  // translate search n destroy help menu
  if (text ==
      "1. Plant/Defuse bomb by completing keycode.\n\n2. Finish keycode by selecting numbers in ascending order.\n\n3. Numbers disappear after first tile is selected.\n\n") {
    if (language == "French") {
      return "1. Plantez/Désamorcez la bombe en complétant le code clé.\n\n2. Terminez le code clé en sélectionnant les nombres dans l'ordre croissant.\n\n3. Les nombres disparaissent après la première tuile est sélectionnée.\n\n";
    } else if (language == "Spanish") {
      return "1. Plantar/Desactivar la bomba completando el código clave.\n\n2. Terminar el código clave seleccionando los números en orden ascendente.\n\n3. Los números desaparecen después de que la primera ficha es seleccionada.\n\n";
    }
  }

  if (language == "French") {
    String? _translated = frenchDict[text];
    if (_translated != null) {
      return _translated;
    } else {
      return text;
    }
  }

  if (language == "Spanish") {
    String? _translated = spanishDict[text];
    if (_translated != null) {
      return _translated;
    } else {
      return text;
    }
  }

  if (language == "German") {
    String? _translated = germanDict[text];
    if (_translated != null) {
      return _translated;
    } else {
      return text;
    }
  }

  if (language == "Russian") {
    String? _translated = russianDict[text];
    if (_translated != null) {
      return _translated;
    } else {
      return text;
    }
  }

  print("No Translation Found: " + text);

  return text;
}

// if (text == "Host") {
//   if (language == "French") {
//     return "Hôte";
//   } else if (language == "Spanish") {
//     return "Anfitrión";
//   }
// }

// if (text == "Language:") {
//   if (language == "French") {
//     return "Langue:";
//   } else if (language == "Spanish") {
//     return "Idioma:";
//   }
// }

// if (text == "Primary Color:") {
//   if (language == "French") {
//     return "Couleur primaire:";
//   } else if (language == "Spanish") {
//     return "Color primario:";
//   }
// }

// if (text == "Display Name:") {
//   if (language == "French") {
//     return "Nom d'affichage:";
//   } else if (language == "Spanish") {
//     return "Nombre de pantalla:";
//   }
// }

// if (text == "Settings") {
//   if (language == "French") {
//     return "Paramètres";
//   } else if (language == "Spanish") {
//     return "Ajustes";
//   }
// }

// if (text == "How to Host a Game") {
//   if (language == "French") {
//     return "Comment héberger un jeu";
//   } else if (language == "Spanish") {
//     return "Cómo anfitrión un juego";
//   }
// }

// if (text == "How to Join a Game") {
//   if (language == "French") {
//     return "Comment rejoindre un jeu";
//   } else if (language == "Spanish") {
//     return "Cómo unirse a un juego";
//   }
// }

// if (text == "Help") {
//   if (language == "French") {
//     return "Aide";
//   } else if (language == "Spanish") {
//     return "Ayuda";
//   }
// }

// if (text == "Domination") {
//   if (language == "French") {
//     return "Domination";
//   } else if (language == "Spanish") {
//     return "Dominación";
//   }
// }

// if (text == "Search and Destroy") {
//   if (language == "French") {
//     return "Chercher et détruire";
//   } else if (language == "Spanish") {
//     return "Buscar y destruir";
//   }
// }

// if (text == "Games") {
//   if (language == "French") {
//     return "Jeux";
//   } else if (language == "Spanish") {
//     return "Juegos";
//   }
// }

// if (text == "Host") {
//   if (language == "French") {
//     return "Hôte";
//   } else if (language == "Spanish") {
//     return "Anfitrión";
//   }
// }

// if (text == "Join") {
//   if (language == "French") {
//     return "Rejoindre";
//   } else if (language == "Spanish") {
//     return "Unirse";
//   }
// }

// if (text == "Enter code") {
//   if (language == "French") {
//     return "Entrer le code";
//   } else if (language == "Spanish") {
//     return "Introduzca el código";
//   }
// }

// if (text == "Back") {
//   if (language == "French") {
//     return "Retour";
//   } else if (language == "Spanish") {
//     return "Atrás";
//   }
// }

// if (text == "Start") {
//   if (language == "French") {
//     return "Démarrer";
//   } else if (language == "Spanish") {
//     return "Comenzar";
//   }
// }

// if (text == "Sound") {
//   if (language == "French") {
//     return "Son";
//   } else if (language == "Spanish") {
//     return "Sonido";
//   }
// }

// if (text == "Passcode Changes") {
//   if (language == "French") {
//     return "Changements de code";
//   } else if (language == "Spanish") {
//     return "Cambios de código";
//   }
// }

// if (text == 'Wait Screen Time:') {
//   if (language == "French") {
//     return "Temps d'attente de l'écran:";
//   } else if (language == "Spanish") {
//     return "Tiempo de espera de la pantalla:";
//   }
// }

// if (text == 'Cards To Remember:') {
//   if (language == "French") {
//     return "Cartes à mémoriser:";
//   } else if (language == "Spanish") {
//     return "Cartas para recordar:";
//   }
// }

// if (text == "Plant/Defuse Attempts:") {
//   if (language == "French") {
//     return "Essais de plante/désamorcer:";
//   } else if (language == "Spanish") {
//     return "Intentos de plantar/desactivar:";
//   }
// }

// if (text == "Bomb Explosion:") {
//   if (language == "French") {
//     return "Explosion de la bombe:";
//   } else if (language == "Spanish") {
//     return "Explosión de la bomba:";
//   }
// }

// if (text == "Starting in") {
//   if (language == "French") {
//     return "Démarrer dans";
//   } else if (language == "Spanish") {
//     return "Comienza en";
//   }
// }

// if (text == "Close") {
//   if (language == "French") {
//     return "Fermer";
//   } else if (language == "Spanish") {
//     return "Cerca";
//   }
// }

// if (text == "Help") {
//   if (language == "French") {
//     return "Aide";
//   } else if (language == "Spanish") {
//     return "Ayuda";
//   }
// }

// if (text == "Search n Destroy") {
//   if (language == "French") {
//     return "Chercher et détruire";
//   } else if (language == "Spanish") {
//     return "Buscar y destruir";
//   }
// }

// if (text == "How to Join Game") {
//   if (language == "French") {
//     return "Comment rejoindre un jeu";
//   } else if (language == "Spanish") {
//     return "Cómo unirse a un juego";
//   }
// }

// if (text == "How to Host Game") {
//   if (language == "French") {
//     return "Comment héberger un jeu";
//   } else if (language == "Spanish") {
//     return "Cómo anfitrión un juego";
//   }
// }

// if (text == "Domination") {
//   if (language == "French") {
//     return "Domination";
//   } else if (language == "Spanish") {
//     return "Dominación";
//   }
// }

// if (text == "Waiting") {
//   if (language == "French") {
//     return "En attente";
//   } else if (language == "Spanish") {
//     return "Esperando";
//   }
// }

// if (text == "Explosion") {
//   if (language == "French") {
//     return "Explosion";
//   } else if (language == "Spanish") {
//     return "Explosión";
//   }
// }

// if (text == "Bomb Planted") {
//   if (language == "French") {
//     return "Bombe plantée";
//   } else if (language == "Spanish") {
//     return "Bomba plantada";
//   }
// }

// if (text == "Bomb Defused") {
//   if (language == "French") {
//     return "Bombe désamorcée";
//   } else if (language == "Spanish") {
//     return "Bomba desactivada";
//   }
// }

// if (text == "1 minute") {
//   if (language == "French") {
//     return "1 minute";
//   } else if (language == "Spanish") {
//     return "1 minuto";
//   }
// }
// if (text == "2 minutes") {
//   if (language == "French") {
//     return "2 minutes";
//   } else if (language == "Spanish") {
//     return "2 minutos";
//   }
// }

// if (text == "5 minutes") {
//   if (language == "French") {
//     return "5 minutes";
//   } else if (language == "Spanish") {
//     return "5 minutos";
//   }
// }

// if (text == "15 minutes") {
//   if (language == "French") {
//     return "15 minutes";
//   } else if (language == "Spanish") {
//     return "15 minutos";
//   }
// }

// if (text == "10 minutes") {
//   if (language == "French") {
//     return "10 minutes";
//   } else if (language == "Spanish") {
//     return "10 minutos";
//   }
// }

// if (text == "10 seconds") {
//   if (language == "French") {
//     return "10 secondes";
//   } else if (language == "Spanish") {
//     return "10 segundos";
//   }
// }

// if (text == "30 seconds") {
//   if (language == "French") {
//     return "30 secondes";
//   } else if (language == "Spanish") {
//     return "30 segundos";
//   }
// }

// if (text == "45 seconds") {
//   if (language == "French") {
//     return "45 secondes";
//   } else if (language == "Spanish") {
//     return "45 segundos";
//   }
// }

// if (text == "GO!") {
//   if (language == "French") {
//     return "GO!";
//   } else if (language == "Spanish") {
//     return "¡VA!";
//   }
// }
