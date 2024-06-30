function connect()
  {
    var url = "ws://" + window.location.hostname + ":8001/";
    console.log("Opening websocket " + url + "\n");
    websock = new WebSocket(url);
    websock.onopen    = function(evt) {sock_open(evt)};
    websock.onclose   = function(evt) {sock_close(evt)};
    websock.onmessage = function(evt) {sock_message(evt)};
    websock.onerror   = function(evt) {sock_error(evt)};
    connected = true;

    input = document.getElementById("keyboard")
    input.addEventListener("change", keyboard)
    println("Keyboard listener")
    
    
  }

function tapeReq () {
    //console.log("tape Request")
    websock.send(JSON.stringify({ "request": "tapeUpdate" }))
}

function register()
{
    //console.log("register button")
    //websock.send(JSON.stringify({"register" : "webclient"}));
    //setInterval(tapeReq, 10)
    println("Activate console")
    
    
}

function keyboard() {
    console.log("Sending KBD")
    //console.log(document.getElementById("keyboard").value)
    websock.send(JSON.stringify({ "keyboard": document.getElementById("keyboard").value}))
    document.getElementById("keyboard").value = ""
}

function load() {
    console.log("load button")
    websock.send(JSON.stringify({"commando": "load"}));
    println("Load program")
}

function start() {
    console.log("start button")
    websock.send(JSON.stringify({ "commando": "start" }));
    println("Starting VMmachine")
    
}

function ctrlC() {
    console.log("ctrl-C")
    websock.send(JSON.stringify({ "commando": "ctrlc" }));
}

function println(text2print){
    console.log("print something")
    document.getElementById("printer").value += (text2print + "\r\n")
    printarea = document.getElementById('printer');
    printarea.scrollTop = printarea.scrollHeight;
}


function plotter(values){
    console.log("Plot something")
    if (myChart) {
        myChart.destroy();
    }
    var ctx = document.getElementById("plotter");
    xyValues =[]
    for (let i = 0; i < values.length; i++) {
        var x;
        var y;
        xyValues[i] = { x: i, y: values[i] };
    }
    var options = {
        responsive: false, // Instruct chart js to respond nicely.
        //maintainAspectRatio: false, // Add to prevent default behaviour of full-width/height 
        legend: { display: false},
        animation: false,
        events: []  
    };
    // End Defining data
    var myChart = new Chart(ctx, {
        type: 'scatter',
        data: {
            datasets: [{
                label: 'PLOTTER', // Name the series
                data: xyValues, // Specify the data values array
                borderColor: '#2196f3', // Add custom color border            
                backgroundColor: '#2196f3', // Add custom color background (Points and Fill)
            }]
        },
        options: options
    });
    }


function xyGraphics(values) {
    console.log("Plot something")
    if (myChart) {
        myChart.destroy();
    }
    var ctx = document.getElementById("plotter");
    xyValues = []
    for (let i = 0; i < values.length; i += 2) {
        var x;
        var y;
        xyValues[i] = { x: values[i+1], y: values[i] };
    }
    var options = {
        responsive: false, // Instruct chart js to respond nicely.
        //maintainAspectRatio: false, // Add to prevent default behaviour of full-width/height 
        legend: { display: false },
        animation: false,
        events: [],
        scales: {
            xAxes: [{
                gridLines: {
                    display: false
                }
            }],
            yAxes: [{
                gridLines: {
                    display: false
                }
            }]
        }
    };
    // End Defining data
    var myChart = new Chart(ctx, {
        type: 'scatter',
        data: {
            datasets: [{
                pointStyle: 'rect',
                pointRadius: 2,
                label: 'PLOTTER', // Name the series
                data: xyValues, // Specify the data values array
                borderColor: '#2196f3', // Add custom color border            
                backgroundColor: '#2196f3', // Add custom color background (Points and Fill)
            }]
        },
        options: options
    });
}





// Display incoming data
function sock_message(evt)
    {
        // console.log(evt.data);
        //console.log(evt.data)
        const start = Date.now();
        input = JSON.parse(evt.data)
        //console.log(input)
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

        } else if ("output" in input) {
            if (input["output"] == '%_plotter') {     
                plotter(input["values"])
            } else if (input["output"] == '%_xygraph') {
                xyGraphics(input["values"])
            }
            

        } else {
            console.log("received other or wrong messagetype\n");
        }
        const end = Date.now();
        const elapsed = end - start;
        console.log(elapsed);
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

