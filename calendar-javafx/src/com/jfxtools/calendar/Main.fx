/*
 * Main.fx
 *
 * Created on Dec 09, 2009, 5:58:57 PM
 */

package com.jfxtools.calendar;

import javafx.stage.Stage;

import javafx.scene.control.Label;
import javafx.scene.control.ProgressIndicator;

import javafx.scene.Scene;
import javafx.scene.paint.Color;

import javafx.scene.shape.Rectangle;

import com.sun.javafx.runtime.Entry;
import java.lang.Runnable;
import java.lang.Void;

import com.jfxtools.calendar.panels.MainPanel;
import com.jfxtools.calendar.utils.AsyncTask;

/**
 * The main class that starts the Calendar application
 * @author Winston Prakash
 */

public function run(){

    var loadingprogress = ProgressIndicator {
        progress: -1
        scaleX: 2
        scaleY: 2
        layoutX : (Constants.initWindowWidth)/2
        layoutY : (Constants.initWindowHeight)/2
    }

    var loadingLabel = Label {
        layoutX : (Constants.initWindowWidth)/2 - 15
        layoutY : (Constants.initWindowHeight)/2 + 30
        width: 100
        text: "Loading .."
        font: Constants.fontBoldExtraLarge2
    }

    var background:Rectangle = Rectangle {
        width: bind scene.width
        height: bind scene.height
        fill: Color.web("#e1b1af")
        strokeWidth: 1
        stroke: Color.rgb(98, 158, 217)
    };

    var scene:Scene = Scene {
        width: Constants.initWindowWidth
        height: Constants.initWindowHeight
        content: [
                background,
                loadingprogress,
                loadingLabel
        ];
        fill: Color.TRANSPARENT
    };

    var stage:Stage = Stage {
        width: Constants.initWindowWidth
        height: Constants.initWindowHeight
        title: "JavaFX Calendar Client"
        scene: scene
    }

    var initializationTask = AsyncTask{
        var loadSuccessful = false;
        var mainPanel;
        action: function():Void {
            mainPanel = MainPanel {
              appContext: AppContext{
                stage: bind stage;
              }
              width: bind scene.width
              height: bind scene.height
            }
            loadSuccessful = true;
        }
        onFinished: function() {
            if (loadSuccessful){
               scene.content = mainPanel;
            }
        }
    }
    initializationTask.start();
}
