TEMPLATE = aux
TARGET = app

RESOURCES += app.qrc

QML_FILES += $$files(*.qml,true) \
             $$files(*.js,true) \
             $$files(*.py,true)

CONF_FILES +=  app.apparmor \
               app.desktop \
               app.png

OTHER_FILES += $${CONF_FILES} \
               $${QML_FILES}


#specify where the qml/js files are installed to
qml_files.path = /app
qml_files.files += $${QML_FILES}

#specify where the config files are installed to
config_files.path = /app
config_files.files += $${CONF_FILES}

INSTALLS+=config_files qml_files

