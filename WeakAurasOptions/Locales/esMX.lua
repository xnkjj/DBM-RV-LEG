if not(GetLocale() == "esMX") then
  return
end

local L = WeakAuras.L

-- WeakAuras/Options
	L["-- Do not remove this comment, it is part of this trigger: "] = "-- No remover este comentario. Es parte de este desencadenador:"
	L["% of Progress"] = "% de progreso"
	L["%i Matches"] = "%i coincidencias"
	--[[Translation missing --]]
	L["%s Color"] = "%s Color"
	--[[Translation missing --]]
	L["%s total auras"] = "%s total auras"
	L["1 Match"] = "1 Coincidencia"
	L["1. Text"] = "1. Texto"
	L["1. Text Settings"] = "1. Preferencias del texto"
	L["2. Text"] = "2. Texto"
	L["2. Text Settings"] = "2. Preferencias del texto"
	L["A 20x20 pixels icon"] = "Un icono de 20x20 píxeles"
	L["A 32x32 pixels icon"] = "Un icono de 32x32 píxeles"
	L["A 40x40 pixels icon"] = "Un icono de 40x40 píxeles"
	L["A 48x48 pixels icon"] = "Un icono de 48x48x píxeles"
	L["A 64x64 pixels icon"] = "Un icono de 64x64 píxeles"
	L["A group that dynamically controls the positioning of its children"] = "Un grupo que controla de manera dinámica la posición de sus dependientes"
	L["Actions"] = "Acciones"
	L["Add a new display"] = "Agregar una nueva aura"
	--[[Translation missing --]]
	L["Add Condition"] = "Add Condition"
	--[[Translation missing --]]
	L["Add Overlay"] = "Add Overlay"
	--[[Translation missing --]]
	L["Add Property Change"] = "Add Property Change"
	L["Add to group %s"] = "Agregar al grupo %s"
	L["Add to new Dynamic Group"] = "Agregar al grupo dinámico"
	L["Add to new Group"] = "Agregar al grupo nuevo"
	L["Add Trigger"] = "Agregar desencadenador"
	L["Addon"] = "Addon"
	L["Addons"] = "Addons"
	L["Align"] = "Alinear"
	L["Allow Full Rotation"] = "Permitir rotación completa"
	L["Alpha"] = "Transparencia"
	L["Anchor"] = "Anchor"
	L["Anchor Point"] = "Punto de anclaje"
	L["Anchored To"] = "Anclado a"
	--[[Translation missing --]]
	L["And "] = "And "
	L["Angle"] = "Ángulo"
	L["Animate"] = "Animar"
	L["Animated Expand and Collapse"] = "Expansión y contracción animada"
	--[[Translation missing --]]
	L["Animates progress changes"] = "Animates progress changes"
	L["Animation relative duration description"] = [=[Duración de la animación relativa a la duración del aura, expresado en fracciones (1/2), porcentaje (50%), o decimales (0.5).
|cFFFF0000Nota:|r si el aura no tiene progreso (por ejemplo, si no tiene un activador basado en tiempo, si el aura no tiene duración, etc.), la animación no correrá.

|cFF4444FFPor Ejemplo:|r
Si la duración de la animación es |cFF00CC0010%|r, y el disparador del aura es un beneficio que dura 20 segundos, la animación de entrada se mostrará por 2 segundos.
Si la duración de la animación es |cFF00CC0010%|r, y el disparador del aura es un beneficio sin tiempo asignado, la animación de entrada se ignorará."]=]
	L["Animation Sequence"] = "Secuencia de animación"
	L["Animations"] = "Animaciones"
	L["Apply Template"] = "Aplicar plantilla"
	L["Arcane Orb"] = "Orbe Arcano"
	L["At a position a bit left of Left HUD position."] = "Un poco a la izquierda de la posición de la visualización frontal (HUD) a la izquierda"
	L["At a position a bit left of Right HUD position"] = "Un poco a la izquierda de la posición de la visualización frontal (HUD) a la derecha"
	L["At the same position as Blizzard's spell alert"] = "En la misma posición que la alerta de hechizos de Blizzard"
	L["Aura Name"] = "Nombre de aura"
	L["Aura Type"] = "Tipo de aura"
	L["Aura(s)"] = "Aura(s)"
	L["Aura:"] = "Aura:"
	L["Auras:"] = "Auras:"
	L["Auto"] = "Automático"
	L["Auto-cloning enabled"] = "Auto-clonación activada"
	L["Automatic Icon"] = "Icono automático"
	L["Backdrop Color"] = "Color de fondo"
	--[[Translation missing --]]
	L["Backdrop in Front"] = "Backdrop in Front"
	L["Backdrop Style"] = "Estilo de fondo"
	L["Background"] = "Fondo"
	L["Background Color"] = "Color de fondo"
	L["Background Inset"] = "Intercalado de fondo"
	L["Background Offset"] = "Desplazamiento del fondo"
	L["Background Texture"] = "Textura de fondo"
	L["Bar Alpha"] = "Transparencia de la barra"
	L["Bar Color"] = "Color de la barra"
	L["Bar Color Settings"] = "Propiedades del color de la barra"
	L["Bar Texture"] = "Textura de la barra"
	L["Big Icon"] = "Icono grande"
	L["Blend Mode"] = "Modo de mezcla"
	L["Blue Rune"] = "Runa azul"
	L["Blue Sparkle Orb"] = "Orbe del destello azul"
	L["Border"] = "Borde"
	L["Border Color"] = "Color del borde"
	--[[Translation missing --]]
	L["Border in Front"] = "Border in Front"
	L["Border Inset"] = "Borde del recuadro"
	L["Border Offset"] = "Desplazamiento del borde"
	L["Border Settings"] = "Configuración de los bordes"
	L["Border Size"] = "Border Size"
	L["Border Style"] = "Estilo de los bordes"
	L["Bottom Text"] = "Texto de fondo"
	--[[Translation missing --]]
	L["Bracket Matching"] = "Bracket Matching"
	L["Button Glow"] = "Resplandor del botón"
	--[[Translation missing --]]
	L["Can be a name or a UID (e.g., party1). A name only works on friendly players in your group."] = "Can be a name or a UID (e.g., party1). A name only works on friendly players in your group."
	L["Cancel"] = "Cancelar"
	L["Channel Number"] = "Número de canal"
	L["Chat Message"] = "Mensaje de chat"
	L["Check On..."] = "Chequear..."
	L["Children:"] = "Dependientes:"
	L["Choose"] = "Elegir"
	L["Choose Trigger"] = "Elegir desencadenador"
	L["Choose whether the displayed icon is automatic or defined manually"] = "Elije si el icono es automático o si se define manualmente"
	L["Clone option enabled dialog"] = "Activar diálogo de clonación"
	L["Close"] = "Cerrar"
	L["Collapse"] = "Contraer"
	L["Collapse all loaded displays"] = "Plegar todas las auras"
	L["Collapse all non-loaded displays"] = "Plegar todas las auras sin cargar"
	L["Color"] = "Color"
	--[[Translation missing --]]
	L["color"] = "color"
	--[[Translation missing --]]
	L["Common Options"] = "Common Options"
	L["Compress"] = "Comprimir"
	--[[Translation missing --]]
	L["Condition %i"] = "Condition %i"
	L["Conditions"] = "Condiciones"
	L["Constant Factor"] = "Factor constante"
	L["Control-click to select multiple displays"] = "Presione Control-Clic para seleccionar varias auras"
	L["Controls the positioning and configuration of multiple displays at the same time"] = "Controla la posición y la configuración de varias auras al mismo tiempo"
	L["Convert to..."] = "Convertir a"
	L["Cooldown"] = "Enfriamiento"
	--[[Translation missing --]]
	L["Copy settings..."] = "Copy settings..."
	--[[Translation missing --]]
	L["Copy to all auras"] = "Copy to all auras"
	L["Copy URL"] = "Copiar URL"
	L["Count"] = "Contar"
	L["Creating buttons: "] = "Crear botones: "
	L["Creating options: "] = "Crear opciones:"
	L["Crop"] = "Cortar"
	L["Crop X"] = "Cortar X"
	L["Crop Y"] = "Cortar Y"
	L["Custom"] = "Personalizado"
	L["Custom Code"] = "Código personalizado"
	L["Custom Function"] = "Función personalizada"
	L["Custom Trigger"] = "Desencadenador personalizado"
	L["Custom trigger event tooltip"] = [=[Escoje qué eventos quieres que revise el desencadenador personalizado.
Múltiples eventos pueden ser especificados. Sepáralos con comas o espacios.

|cFF4444FFPor Ejemplo:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED
]=]
	L["Custom trigger status tooltip"] = [=[Escoje qué eventos quieres que revise el desencadenador personalizado.
Ya que éste es un desencadenador de estado, los eventos especificados pueden ser invocados por WeakAuras sin ningún argumento.
Múltiples eventos pueden ser especificados. Sepáralos con comas o espacios.

|cFF4444FFPor Ejemplo:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED]=]
	L["Custom Untrigger"] = "Desencadenador No-Personalizado"
	L["Debuff Type"] = "Tipo de perjuicio"
	L["Default"] = "Estándar"
	L["Delete"] = "Eliminar"
	L["Delete all"] = "Eliminar todo"
	L["Delete children and group"] = "Eliminar dependientes y grupo"
	L["Delete Trigger"] = "Eliminar desencadenador"
	L["Desaturate"] = "Desaturar"
	--[[Translation missing --]]
	L["Differences"] = "Differences"
	--[[Translation missing --]]
	L["Disable Import"] = "Disable Import"
	L["Disabled"] = "Desactivado"
	L["Discrete Rotation"] = "Rotación discreta"
	L["Display"] = "Mostrar"
	L["Display Icon"] = "Mostrar icono"
	L["Display Text"] = "Mostrar texto"
	L["Displays a text, works best in combination with other displays"] = "Muetra un texto. Funciona mejor combinado con otras visualizaciones"
	L["Distribute Horizontally"] = "Distribución horizontal"
	L["Distribute Vertically"] = "Distribución vertical"
	L["Do not group this display"] = "No combines esta visualización"
	L["Done"] = "Finalizado"
	--[[Translation missing --]]
	L["Down"] = "Down"
	L["Drag to move"] = "Arrastrar para mover"
	L["Duplicate"] = "Duplicar"
	--[[Translation missing --]]
	L["Duplicate All"] = "Duplicate All"
	L["Duration (s)"] = "Duración"
	L["Duration Info"] = "Información sobre la duración"
	L["Dynamic Group"] = "Grupo dinámico"
	L["Dynamic Information"] = "Información dinámica"
	L["Dynamic information from first active trigger"] = "Información dinámica del primer desencadenador activo"
	L["Dynamic information from Trigger %i"] = "Información dinámica del desencadenador %i"
	L["Dynamic text tooltip"] = "Descripción emergente dinámica"
	L["Enabled"] = "Activado"
	L["End Angle"] = "Ángulo de fin"
	L["Enter an aura name, partial aura name, or spell id"] = "Introduce el nombre de un aura (total o parcial), o el identificador del hechizo"
	L["Event"] = "Evento"
	L["Event Type"] = "Event Type"
	L["Event(s)"] = "Evento(s)"
	--[[Translation missing --]]
	L["Everything"] = "Everything"
	L["Expand"] = "Expandir"
	L["Expand all loaded displays"] = "Expandir todas las auras cargadas"
	L["Expand all non-loaded displays"] = "Expandir todas las auras sin cargar"
	L["Expansion is disabled because this group has no children"] = "No se puede expandir ya que este grupo no posee dependientes"
	L["Export to Lua table..."] = "Exportar a tabla de Lua...."
	L["Export to string..."] = "Exportar al hilo..."
	L["Fade"] = "Apagar"
	L["Fade In"] = "Fundir"
	L["Fade Out"] = "Difuminar"
	--[[Translation missing --]]
	L["False"] = "False"
	L["Finish"] = "Completar"
	L["Fire Orb"] = "Orbe de fuego"
	L["Font"] = "Font"
	L["Font Flags"] = "Fuente de las banderas"
	L["Font Size"] = "Tamaño de las banderas"
	L["Font Type"] = "Font Type"
	L["Foreground Color"] = "Color frontal"
	L["Foreground Texture"] = "Textural frontal"
	L["Frame"] = "Macro"
	L["Frame Strata"] = "Importancia del macro"
	L["From Template"] = "Desde la plantilla"
	L["Full Scan"] = "Escaneo completo"
	L["General Text Settings"] = "Preferencias generales de texto"
	L["Glow"] = "Resplandor"
	L["Glow Action"] = "Acción de resplandor"
	L["Green Rune"] = "Runa verde"
	L["Group"] = "Grupo"
	L["Group (verb)"] = "Agrupar "
	L["Group aura count description"] = [=[La cantidad de miembros del grupo o banda que deben estar afectados por las auras indicadas para la activación.

Si el número introducido es un entero (ej. 5), la cantidad de miembros del grupo o banda que deben estar afectados será absoluta.

Si el número introducido es una fracción (1/2), decimal (0.5) o porcentaje (50%%), se interpretará como que la cantidad de miembros del grupo o banda que deben estar afectados es una fracción del total.

|cFF4444FFPor ejemplo:|r
Con |cFF00CC00> 0|r se activará cuando cualquier miembro del grupo o banda esté afectado.
Con |cFF00CC00= 100%%|r se activará cuando todos los miembros del grupo o banda estén afectados.
Con |cFF00CC00!= 2|r se activará cuando el número de miembros del grupo o banda afectados no sea 2.
Con |cFF00CC00<= 0.8|r se activará cuando menos del 80%% del grupo o banda esté afectado (4 de 5 miembros en grupos, 8 de 10 ó 20 de 25 en bandas).
Con |cFF00CC00> 1/2|r se activará cuando más de la mitad de miembros del grupo o banda estén afectados.
Con |cFF00CC00>= 0|r se activará siempre.]=]
	L["Group Member Count"] = "Contador de miembros del grupo"
	L["Grow"] = "Crecer"
	L["Hawk"] = "Halcón"
	L["Height"] = "Alto"
	L["Hide"] = "Ocultar"
	L["Hide on"] = "Ocultar en"
	L["Hide this group's children"] = "Ocultar los dependientes de este grupo"
	L["Hide When Not In Group"] = "Ocultar cuando no esté en grupo"
	L["Horizontal Align"] = "Alineación horizontal"
	L["Horizontal Bar"] = "Barra horizontal"
	L["Horizontal Blizzard Raid Bar"] = "Barra horizontal de banda de Blizzard"
	L["Huge Icon"] = "Icono enorme"
	L["Hybrid Position"] = "Posición híbrida"
	L["Hybrid Sort Mode"] = "Modo de orden híbrido"
	L["Icon"] = "Icono"
	L["Icon Color"] = "Color de icono"
	L["Icon Info"] = "Información de icono"
	L["Icon Inset"] = "Interior del icono"
	--[[Translation missing --]]
	L["If"] = "If"
	--[[Translation missing --]]
	L["If this option is enabled, you are no longer able to import auras."] = "If this option is enabled, you are no longer able to import auras."
	--[[Translation missing --]]
	L["If Trigger %s"] = "If Trigger %s"
	L["Ignored"] = "Ignorar"
	L["Import"] = "Importar"
	L["Import a display from an encoded string"] = "Importar un aura desde un texto cifrado"
	L["Inverse"] = "Invertido"
	--[[Translation missing --]]
	L["Inverse Slant"] = "Inverse Slant"
	L["Justify"] = "Justificar"
	--[[Translation missing --]]
	L["Keep Aspect Ratio"] = "Keep Aspect Ratio"
	L["Leaf"] = "Hoja"
	L["Left 2 HUD position"] = "Posición izquierda 2 de visualización frontal (HUD)"
	L["Left HUD position"] = "Posición izquierda de visualización frontal (HUD)"
	L["Left Text"] = "Texto a la izquierda"
	L["Load"] = "Cargar"
	L["Loaded"] = "Cargado"
	--[[Translation missing --]]
	L["Loop"] = "Loop"
	L["Low Mana"] = "Maná insuficiente"
	L["Main"] = "Principal"
	L["Manage displays defined by Addons"] = "Administra las auras definidas por los Addons"
	L["Medium Icon"] = "Icono mediano"
	L["Message"] = "Mensaje"
	L["Message Prefix"] = "Prefijo del mensaje"
	L["Message Suffix"] = "Sufijo del mensaje"
	L["Message Type"] = "Tipo de mensaje"
	L["Message type:"] = "Tipo de mensaje:"
	L["Mirror"] = "Reflejar"
	L["Model"] = "Modelo"
	L["Move Down"] = "Bajar"
	L["Move this display down in its group's order"] = "Bajar esta aura conservando el orden de su grupo"
	L["Move this display up in its group's order"] = "Subir esta aura conservando el orden de su grupo"
	L["Move Up"] = "Subir"
	L["Multiple Displays"] = "Múltiples auras"
	L["Multiple Triggers"] = "Desencadenadores múltiples"
	L["Multiselect ignored tooltip"] = [=[|cFFFF0000Ignorado|r - |cFF777777Único|r - |cFF777777Múltiple|r
Ésta opción no se usará al determinar cuándo se mostrará el aura]=]
	L["Multiselect multiple tooltip"] = [=[|cFF777777Ignorado|r - |cFF777777Único|r - |cFF00FF00Múltiple|r
Cualquier combinación de valores es posible.]=]
	L["Multiselect single tooltip"] = [=[|cFF777777Ignorado|r - |cFF00FF00Único|r - |cFF777777Múltiple|r
Sólo un valor coincidente puede ser escogido.]=]
	L["Name Info"] = "Información del nombre"
	L["Negator"] = "Negar"
	L["Never"] = "Nunca"
	L["New"] = "Nuevo"
	L["No"] = "No"
	L["No Children"] = "Sin dependientes"
	L["No tooltip text"] = "Sin texto de descripción"
	L["None"] = "Nada"
	L["Not all children have the same value for this option"] = "No todos los dependientes contienen la misma configuración."
	L["Not Loaded"] = "Sin cargar"
	L["Offer a guided way to create auras for your class"] = "Ofrece una guía para la creación de auras de tu clase."
	L["Okay"] = "Aceptar"
	L["On Hide"] = "Ocultar"
	L["On Init"] = "Iniciar"
	L["On Show"] = "Mostrar"
	L["Only match auras cast by people other than the player"] = "Solamente corresponder auras conjuradas por otros jugadores"
	L["Only match auras cast by the player"] = "Solamente corresponder auras conjuradas el jugador"
	L["Operator"] = "Operador"
	--[[Translation missing --]]
	L["Options will open after combat ends."] = "Options will open after combat ends."
	L["or"] = "o"
	L["Orange Rune"] = "Runa naranja"
	L["Orientation"] = "Orientación"
	L["Outline"] = "Borde"
	--[[Translation missing --]]
	L["Overflow"] = "Overflow"
	--[[Translation missing --]]
	L["Overlay %s Info"] = "Overlay %s Info"
	--[[Translation missing --]]
	L["Overlays"] = "Overlays"
	L["Own Only"] = "Solo mías"
	--[[Translation missing --]]
	L["Paste Action Settings"] = "Paste Action Settings"
	--[[Translation missing --]]
	L["Paste Animations Settings"] = "Paste Animations Settings"
	--[[Translation missing --]]
	L["Paste Condition Settings"] = "Paste Condition Settings"
	--[[Translation missing --]]
	L["Paste Display Settings"] = "Paste Display Settings"
	--[[Translation missing --]]
	L["Paste Group Settings"] = "Paste Group Settings"
	--[[Translation missing --]]
	L["Paste Load Settings"] = "Paste Load Settings"
	--[[Translation missing --]]
	L["Paste Settings"] = "Paste Settings"
	L["Paste text below"] = "Pegar texto debajo"
	--[[Translation missing --]]
	L["Paste Trigger Settings"] = "Paste Trigger Settings"
	L["Play Sound"] = "Reproducir sonido"
	L["Portrait Zoom"] = "Zoom"
	--[[Translation missing --]]
	L["Position Settings"] = "Position Settings"
	L["Preset"] = "Predefinido"
	L["Prevents duration information from decreasing when an aura refreshes. May cause problems if used with multiple auras with different durations."] = "Previene que el temporizador siga contando cuando el aura se refresca. Ten cuidado, pueden aparecer problemas si usas múltiples auras con múltiples duraciones."
	L["Processed %i chars"] = "%i Personajes procesados"
	L["Progress Bar"] = "Barra de progreso"
	L["Progress Texture"] = "Textura de progreso"
	L["Purple Rune"] = "Runa morada"
	L["Put this display in a group"] = "Colocar esta aura en un grupo"
	L["Radius"] = "Radio"
	L["Re-center X"] = "Centrar X"
	L["Re-center Y"] = "Centrar Y"
	--[[Translation missing --]]
	L["Regions of type \"%s\" are not supported."] = "Regions of type \"%s\" are not supported."
	L["Remaining Time"] = "Tiempo restante"
	L["Remaining Time Precision"] = "Precisión de tiempo restante"
	--[[Translation missing --]]
	L["Remove"] = "Remove"
	--[[Translation missing --]]
	L["Remove this condition"] = "Remove this condition"
	L["Remove this display from its group"] = "Remover esta aura del grupo"
	--[[Translation missing --]]
	L["Remove this property"] = "Remove this property"
	L["Rename"] = "Renombrar"
	--[[Translation missing --]]
	L["Repeat After"] = "Repeat After"
	--[[Translation missing --]]
	L["Repeat every"] = "Repeat every"
	L["Required for Activation"] = "Necesario para la activación"
	L["Right 2 HUD position"] = "Posición derecha 2 de visualización (HUD)"
	L["Right HUD position"] = "Posición derecha de visualización (HUD)"
	L["Right Text"] = "Texto derecho"
	L["Right-click for more options"] = "Clic derecho para más opciones"
	L["Rotate"] = "Rotar"
	L["Rotate In"] = "Rotar hacia adentro"
	L["Rotate Out"] = "Rotar hacia afuera"
	L["Rotate Text"] = "Rotar texto"
	L["Rotation"] = "Rotación"
	L["Rotation Mode"] = "Modo de rotación"
	L["Same"] = "Igual"
	L["Scale"] = "Ajustar tamaño"
	L["Search"] = "Buscar"
	L["Select the auras you always want to be listed first"] = "Selecciona las auras que quieras que sean listadas primero"
	L["Send To"] = "Enviar a"
	L["Set Parent to Anchor"] = "Asignar grupo primario al anclaje"
	L["Set tooltip description"] = "Establecer descripción de texto emergente"
	--[[Translation missing --]]
	L["Settings"] = "Settings"
	L["Shift-click to create chat link"] = "Shift-Clic para un crear un enlace de chat"
	L["Show all matches (Auto-clone)"] = "Mostrar todas las coincidencias (Auto-clonación)"
	L["Show Cooldown Text"] = "Mostrar el texto del tiempo de recarga"
	--[[Translation missing --]]
	L["Show If Unit Is Invalid"] = "Show If Unit Is Invalid"
	L["Show model of unit "] = "Mostrar el modelo de la unidad"
	--[[Translation missing --]]
	L["Show On"] = "Show On"
	L["Show this group's children"] = "Mostrar los dependientes de este grupo"
	L["Shows a 3D model from the game files"] = "Muestra un modelo 3D de los archivos del juego"
	L["Shows a custom texture"] = "Muestra una textura personalizada"
	L["Shows a progress bar with name, timer, and icon"] = "Muestra la barra de progreso con el nombre, el temporizador y el icono"
	L["Shows a spell icon with an optional cooldown overlay"] = "Muestra el icono de hechizo con una superposición opcional del tiempo de recarga"
	L["Shows a texture that changes based on duration"] = "Muestra una textura que cambia según la duración"
	L["Shows one or more lines of text, which can include dynamic information such as progress or stacks"] = "Muestra una o más lineas del texto, el cual puede incluir información dinámica como el progreso o la acumulación"
	L["Size"] = "Tamaño"
	--[[Translation missing --]]
	L["Slant Amount"] = "Slant Amount"
	--[[Translation missing --]]
	L["Slant Mode"] = "Slant Mode"
	--[[Translation missing --]]
	L["Slanted"] = "Slanted"
	L["Slide"] = "Arrastrar"
	L["Slide In"] = "Arrastrar dentro"
	L["Slide Out"] = "Arrastrar fuera"
	L["Small Icon"] = "Icono pequeño"
	--[[Translation missing --]]
	L["Smooth Progress"] = "Smooth Progress"
	L["Sort"] = "Filtrar"
	L["Sound"] = "Sonido"
	L["Sound Channel"] = "Canal de sonido"
	L["Sound File Path"] = "Ruta del fichero de sonido"
	L["Sound Kit ID"] = "ID del kit de sonido"
	L["Space"] = "Espacio"
	L["Space Horizontally"] = "Espacio horizontal"
	L["Space Vertically"] = "Espacio vertical"
	L["Spark"] = "Chispa"
	L["Spark Settings"] = "Propiedades de la chispa"
	L["Spark Texture"] = "Textura de la chispa"
	L["Specific Unit"] = "Unidad específica"
	L["Spell ID"] = "ID de hechizo"
	L["Stack Count"] = "Contador de acumulaciones"
	L["Stack Info"] = "Información de acumulaciones"
	L["Stacks"] = "Acumulaciones"
	L["Stacks Settings"] = "Configuración de Acumulaciones"
	L["Stagger"] = "Tambaleo"
	L["Star"] = "Estrella"
	L["Start"] = "Comenzar"
	L["Start Angle"] = "Ángulo de inicio"
	L["Status"] = "Estado"
	L["Stealable"] = "Puede robarse"
	L["Sticky Duration"] = "Duración adhesiva"
	--[[Translation missing --]]
	L["Stop Sound"] = "Stop Sound"
	L["Symbol Settings"] = "Configuración de símbolos"
	L["Temporary Group"] = "Grupo temporal"
	L["Text"] = "Texto"
	L["Text Color"] = "Color del texto"
	L["Text Position"] = "Posición del texto"
	L["Texture"] = "Textura"
	L["Texture Info"] = "Información de la textura"
	--[[Translation missing --]]
	L["Texture Wrap"] = "Texture Wrap"
	L["The duration of the animation in seconds."] = "Duración de la animación (en segundos)."
	--[[Translation missing --]]
	L["The duration of the animation in seconds. The finish animation does not start playing until after the display would normally be hidden."] = "The duration of the animation in seconds. The finish animation does not start playing until after the display would normally be hidden."
	L["The type of trigger"] = "El tipo de desencadenador"
	--[[Translation missing --]]
	L["Then "] = "Then "
	L["This display is currently loaded"] = "Esta aura está cargada"
	L["This display is not currently loaded"] = "Esta aura no está cargada"
	L["This region of type \"%s\" is not supported."] = "No soporta el tipo de región \"%s\"."
	L["Time in"] = "Contar en"
	L["Tiny Icon"] = "Icono miniatura"
	L["To Frame's"] = "Al macro"
	L["to group's"] = "Al grupo"
	L["To Personal Ressource Display's"] = "A los recursos personales de aura"
	L["To Screen's"] = "A la pantalla"
	L["Toggle the visibility of all loaded displays"] = "Alterar la visibilidad de todas las auras cargadas"
	L["Toggle the visibility of all non-loaded displays"] = "Alterar la visibilidad de todas las auras no cargadas"
	L["Toggle the visibility of this display"] = "Alterar la visibilidad de esta aura"
	L["Tooltip"] = "Descripción emergente"
	L["Tooltip on Mouseover"] = "Descripción emergente al pasar el ratón"
	L["Top HUD position"] = "Posición superior de la visualización (HUD)"
	L["Top Text"] = "Texto superior"
	L["Total Time Precision"] = "Precisión del tiempo total"
	L["Trigger"] = "Desencadenador"
	L["Trigger %d"] = "Desencadenador %d"
	L["Trigger:"] = "Desencadenador:"
	--[[Translation missing --]]
	L["True"] = "True"
	L["Type"] = "Tipo"
	L["Undefined"] = "Indefinido"
	L["Ungroup"] = "Desagrupar"
	L["Unit"] = "Unidad"
	L["Unlike the start or finish animations, the main animation will loop over and over until the display is hidden."] = "Ignorar animaciones de inicio y final: la animación principal se repetirá hasta que el aura se oculte."
	--[[Translation missing --]]
	L["Up"] = "Up"
	L["Update Custom Text On..."] = "Actualizar texto personalizado en..."
	L["Use Full Scan (High CPU)"] = "Escaneo Total (carga el procesador)"
	--[[Translation missing --]]
	L["Use SetTransform (will change behaviour in 7.3)"] = "Use SetTransform (will change behaviour in 7.3)"
	L["Use tooltip \"size\" instead of stacks"] = "Utilizar \"tamaño\" en vez de acumulaciones"
	--[[Translation missing --]]
	L["Used in auras:"] = "Used in auras:"
	--[[Translation missing --]]
	L["Version: "] = "Version: "
	L["Vertical Align"] = "Alineación vertical"
	L["Vertical Bar"] = "Barra vertical"
	L["View"] = "Visualización"
	L["Width"] = "Ancho"
	L["X Offset"] = "Posición de X"
	L["X Rotation"] = "Rotación de X"
	L["X Scale"] = "Ajuste de tamaño de X"
	L["Y Offset"] = "Posición de Y"
	L["Y Rotation"] = "Rotación de Y"
	L["Y Scale"] = "Ajuste de tamaño de Y"
	L["Yellow Rune"] = "Runa amarilla"
	L["Yes"] = "Si"
	L["Z Offset"] = "Posición de Z"
	L["Z Rotation"] = "Rotación de Z"
	L["Zoom"] = "Ampliar"
	L["Zoom In"] = "Acercar"
	L["Zoom Out"] = "Alejar"

