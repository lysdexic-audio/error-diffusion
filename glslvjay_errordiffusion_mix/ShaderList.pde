ArrayList<GShader> shaderList = new ArrayList<GShader>();
int currentShaderIdx = 0;


//load all the suitable shaders from the data directory
//add the parameters for each shader
void setupShaders() {
  textureWrap(REPEAT);
  
  //soundinput shader
  GShader inputsound = new GShader("inputsound.frag");
  shaderList.add(inputsound);
  
  //cubescape shader
  GShader cubescape = new GShader("cubescape.frag");
  shaderList.add(cubescape);
  cubescape.parameters.add(new Param("brightness",-0.5,5));
  cubescape.parameters.add(new Param("rotation",-1,1));
  cubescape.tex1files = new String[]{ "wood1.jpg" };
  
  //galaxy shader
  GShader galaxy = new GShader("galaxy.frag");
  shaderList.add(galaxy);
  galaxy.parameters.add(new Param("hideStars"));
  galaxy.tex1files = new String[]{ "seamlesstex/" };

  //ringOfColor shader
  //GShader ringOfColor = new GShader("ringofcolor.glsl");
  //shaderList.add(ringOfColor);
  //galaxy.parameters.add(new Param("hideStars"));
  //galaxy.tex1files = new String[]{ "seamlesstex/" };
  
// x.glsl FIRST
  GShader x = new GShader("x.frag");
  shaderList.add(x);
  x.parameters.add(new Param("ShiftXUP",-0.5,5));
  x.parameters.add(new Param("ShiftX",-0.5,5));
  x.parameters.add(new Param("ShiftXLineDistance",-0.5,5));
  x.parameters.add(new Param("ShiftXHorizontal",-0.5,5));
  x.parameters.add(new Param("ShiftXX",-0.5,5));
  x.parameters.add(new Param("ShiftXY",-0.5,5));
  
  
    
// GridXYConvertMouse.frag
  GShader GridXYConvertMouse = new GShader("GridXYConvertMouse.frag");
  shaderList.add(GridXYConvertMouse);
  
    

  

  
  //init current shader
  initCurrentShader();
}


void initCurrentShader() {
  //remove old osc plugs using new instance
  if (oscP5 != null) {
    oscP5.stop();
    oscP5.dispose();
  }
  oscP5 = new OscP5(this, 4000);

  //osc plug prev / next shaders 
  OscMessage labelData = new OscMessage("/1/label1");
  labelData.add(shaderList.get(currentShaderIdx).path);//append path of current shader to display
  oscP5.send(labelData, remoteAddr);//send the message
  //plug
  oscP5.plug(this,"prevShader","/1/push1");
  oscP5.plug(this,"nextShader","/1/push2");
  oscP5.plug(this,"pick1","/3/toggle1");
  oscP5.plug(this,"pick2","/3/toggle2");
  oscP5.plug(this,"pick3","/3/toggle3");

  //plug prev / next shader
  shaderList.get(currentShaderIdx).addOscPlugs();
}

void prevShader(float val) {
  if (val==0.0){
    currentShaderIdx = (currentShaderIdx - 1) % shaderList.size();
    if (currentShaderIdx<0)
      currentShaderIdx=shaderList.size()-1;
    initCurrentShader();
  }
}
void nextShader(float val) {
  if (val==0.0){
    currentShaderIdx = (currentShaderIdx + 1) % shaderList.size();
    initCurrentShader();
  }
}


void pick1(float val) {
  if (val==0.0){
    currentShaderIdx = 1;
    initCurrentShader();
  }
}
void pick2(float val) {
  if (val==0.0){
    currentShaderIdx = 2;
    initCurrentShader();
  }
}
void pick3(float val) {
  if (val==0.0){
    currentShaderIdx = 3;
    initCurrentShader();
  }
}
