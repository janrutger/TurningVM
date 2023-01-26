function connect()
  {
    var url = "ws://0.0.0.0:8001/";
    console.log("Opening websocket " + url + "\n");
    websock = new WebSocket(url);
    websock.onopen    = function(evt) {sock_open(evt)};
    websock.onclose   = function(evt) {sock_close(evt)};
    websock.onmessage = function(evt) {sock_message(evt)};
    websock.onerror   = function(evt) {sock_error(evt)};
    connected = true;

    input = document.getElementById("keyboard")
    input.addEventListener("change", keyboard)
    
  }

function register()
{
    console.log("register button")
    websock.send(JSON.stringify({"register" : "webclient"}));
    println("Activate console")
    
    //println("Keyboard activated")
}

function keyboard() {
    console.log("getting input")
    //document.getElementById("keyboard").focus()
    //input = document.getElementById("keyboard")
    // input.addEventListener("keypress", function (event) {
    //    if (event.key === "Enter") {
            //event.preventDefault();
    console.log(document.getElementById("keyboard").value)
    websock.send(JSON.stringify({ "keyboard": document.getElementById("keyboard").value}))
    document.getElementById("keyboard").value = ""
        }
    //});
//}

function load() {
    console.log("load button")
    websock.send(JSON.stringify({"commando": "load"}));
    println("Load program")
}

function start() {
    console.log("start button")
    websock.send(JSON.stringify({ "commando": "start" }));
    println("Start VMmachine")
}

function println(text2print){
    console.log("print something")
    document.getElementById("printer").value += (text2print + "\n")
    printarea = document.getElementById('printer');
    printarea.scrollTop = printarea.scrollHeight;
}





// Display incoming data
function sock_message(evt)
    {
        // console.log(evt.data);
        console.log(evt.data)
        input = JSON.parse(evt.data)
        console.log(input)
        if ("tapeUpdate" in input) {
            console.log("received tape update\n")

            document.getElementById("STleft").innerHTML  = input["tapeUpdate"]["ST"][0].slice(-70)
            document.getElementById("SThead").innerHTML  = input["tapeUpdate"]["ST"][1]
            document.getElementById("STright").innerHTML = input["tapeUpdate"]["ST"][2].slice(0, 50)

            document.getElementById("RAleft").innerHTML  = input["tapeUpdate"]["RA"][0].slice(-70)
            document.getElementById("RAhead").innerHTML  = input["tapeUpdate"]["RA"][1]
            document.getElementById("RAright").innerHTML = input["tapeUpdate"]["RA"][2].slice(0, 50)

            document.getElementById("RBleft").innerHTML  = input["tapeUpdate"]["RB"][0].slice(-70)
            document.getElementById("RBhead").innerHTML  = input["tapeUpdate"]["RB"][1]
            document.getElementById("RBright").innerHTML = input["tapeUpdate"]["RB"][2].slice(0, 50)

            document.getElementById("Sleft").innerHTML  = input["tapeUpdate"]["S"][0].slice(-70)
            document.getElementById("Shead").innerHTML  = input["tapeUpdate"]["S"][1]
            document.getElementById("Sright").innerHTML = input["tapeUpdate"]["S"][2].slice(0, 50)

        } else if ("printline" in input){
            println(input["printline"])

        } else if ("inputReq" in input){
            keyboard()
        

        } else {
            console.log("received other or wrong messagetype\n");
        }
    }

function sock_open(evt)
    {
        console.log("Connected\n");
    }

function sock_close(evt)
    {
       console.log("\nDisconnected\n");
    }

  function sock_error(evt)
    {
        console.log("Socket error\n");
        websock.close();
    }



window.addEventListener("load", connect, false);

