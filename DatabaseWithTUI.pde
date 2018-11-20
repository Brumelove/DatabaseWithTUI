  import TUIO.*; //Tangible User Interface



  TuioProcessing tuioClient;
  tuioClient=new TuioProcessing(this); //Instantiate the TUIO Client Library on this Application

  void addTuioObject(TuioObject tobj){
   log(tobj.getSymbolID())
  }

  void removeTuioObject(TuioObject tobj){
  //appEngine.getLevel().removeTuioObject(tobj);
	log(tobj.getSymbolID());
  }

  void updateTuioObject(TuioObject tobj){
  //appEngine.getLevel().updateTuioObject(tobj);
	log(tobj.getSymbolID());
  }

  void addTuioCursor(TuioCursor tcur){
  //appEngine.getLevel().addTuioCursor(tcur);
    log(tobj.getSymbolID());
  }

  void removeTuioCursor(TuioCursor tcur){
  //appEngine.getLevel().removeTuioCursor(tcur);
	log(tcur.getSymbolID());	
  }

  void updateTuioCursor(TuioCursor tcur){
 	log(tcur.getSymbolID());
  }
