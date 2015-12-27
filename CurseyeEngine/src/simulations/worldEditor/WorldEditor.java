package simulations.worldEditor;

import engine.gui.GUI;
import engine.gui.GUIs.EngineGUI;
import engine.lighting.DirectionalLight;
import engine.main.CoreEngine;
import engine.main.RenderingEngine;
import engine.math.Vec3f;
import simulations.templates.Simulation;
import simulations.templates.TerrainSimulation;

public class WorldEditor extends TerrainSimulation{
	
public static void main(String[] args) {
		
		Simulation simulation = new WorldEditor();
		GUI gui = new EngineGUI();
		CoreEngine coreEngine = new CoreEngine(1080, 640, "Terrain", simulation, gui);
		coreEngine.createWindow();
		coreEngine.start();
	}

	public void init()
	{	
		super.init();
		setWater(new Ocean());
		SwingGUI.setSimulation(this);
		SwingGUI.start();
		RenderingEngine.setDirectionalLight(new DirectionalLight(new Vec3f(0,-1,0), new Vec3f(1.0f,1.0f,1.0f), new Vec3f(1.0f, 0.95f, 0.75f), 0.9f));
	}
}