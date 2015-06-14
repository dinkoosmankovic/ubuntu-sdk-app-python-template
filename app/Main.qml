import QtQuick 2.0
import Ubuntu.Components 1.1
import io.thp.pyotherside 1.4


/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "ubuntuapppythonproject.dinko-metalac"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(100)
    height: units.gu(75)


    Python {
        id: pythonInterpreter

        onError: {
            console.log('python error: ' + traceback);
        }

        onReceived: {
            console.log('got message from python: ' + data);
        }
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('.'));
            importModule('setpaths', function () {
                call('setpaths.set_env_paths', [], function(result) {
                    //console.log(result)
                });
            });

        }
    }


    Page {
        title: i18n.tr("Simple")

        Column {
            spacing: units.gu(1)
            anchors {
                margins: units.gu(2)
                fill: parent
            }

            Label {
                id: label
                objectName: "label"

                text: i18n.tr("Hello..")
            }

            Button {
                objectName: "button"
                width: parent.width

                text: i18n.tr("Tap me!")

                onClicked: {
                    pythonInterpreter.addImportPath(Qt.resolvedUrl('./python_files'));
                    pythonInterpreter.importModule('main', function () {
                        pythonInterpreter.call('main.test_func_one', [], function(result) {
                            label.text = result
                        });
                    });
                }
            }

            Button {
                objectName: "button2"
                width: parent.width

                text: i18n.tr("Tap me!")

                onClicked: {
                    var someArgument = "This is a string argument"
                    pythonInterpreter.addImportPath(Qt.resolvedUrl('./python_files'));
                    pythonInterpreter.importModule('main', function () {
                        pythonInterpreter.call('main.test_func_two', [someArgument], function(result) {
                            label.text = result
                        });
                    });
                }

            }
        }
    }
}

