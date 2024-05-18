//
// Classroom License -- for classroom instructional use only.  Not for
// government, commercial, academic research, or other organizational use.
//
// File: ert_main.cpp
//
// Code generated for Simulink model 'SatelliteServicing_Mission'.
//
// Model version                  : 4.4
// Simulink Coder version         : 9.8 (R2022b) 13-May-2022
// C/C++ source code generated on : Mon May  1 12:51:07 2023
//
// Target selection: ert.tlc
// Embedded hardware selection: Intel->x86-64 (Windows64)
// Code generation objectives: Unspecified
// Validation result: Not run
//
#include <stdio.h>              // This example main program uses printf/fflush
#include "SatelliteServicing_Mission.h" // Model header file

static ExtU_SatelliteServicing_Missi_T SatelliteServicing_Mission_U;// External inputs 
static ExtY_SatelliteServicing_Missi_T SatelliteServicing_Mission_Y;// External outputs 
const char *RT_MEMORY_ALLOCATION_ERROR = "memory allocation error";
RT_MODEL_SatelliteServicing_M_T *SatelliteServicing_Mission_M;

//
// Associating rt_OneStep with a real-time clock or interrupt service routine
// is what makes the generated code "real-time".  The function rt_OneStep is
// always associated with the base rate of the model.  Subrates are managed
// by the base rate from inside the generated code.  Enabling/disabling
// interrupts and floating point context switches are target specific.  This
// example code indicates where these should take place relative to executing
// the generated code step function.  Overrun behavior should be tailored to
// your application needs.  This example simply sets an error status in the
// real-time model and returns from rt_OneStep.
//
void rt_OneStep(RT_MODEL_SatelliteServicing_M_T *const
                SatelliteServicing_Mission_M);
void rt_OneStep(RT_MODEL_SatelliteServicing_M_T *const
                SatelliteServicing_Mission_M)
{
  static boolean_T OverrunFlag{ false };

  // Disable interrupts here

  // Check for overrun
  if (OverrunFlag) {
    rtmSetErrorStatus(SatelliteServicing_Mission_M, "Overrun");
    return;
  }

  OverrunFlag = true;

  // Save FPU context here (if necessary)
  // Re-enable timer or interrupt here
  // Set model inputs here

  // Step the model
  //SatelliteServicing_Mission_step(SatelliteServicing_Mission_M,
  //  &SatelliteServicing_Mission_U, &SatelliteServicing_Mission_Y);
  SatelliteServicing_Mission_step(SatelliteServicing_Mission_M,
    &SatelliteServicing_Mission_Y);

  // Get model outputs here

  // Indicate task complete
  OverrunFlag = false;

  // Disable interrupts here
  // Restore FPU context here (if necessary)
  // Enable interrupts here
}

extern "C" int_T sim_init(real_T simStepSize, int_T nAgents, real_T* initial_conditions, real_T mean_motion, int_T* nFaces)
{
  // Allocate model data
  SatelliteServicing_Mission_M = SatelliteServicing_Mission
    (&SatelliteServicing_Mission_U, &SatelliteServicing_Mission_Y);
  if (SatelliteServicing_Mission_M == (nullptr)) {
    (void)fprintf(stderr, "Memory allocation error during model registration");
    return(1);
  }

  if (rtmGetErrorStatus(SatelliteServicing_Mission_M) != (nullptr)) {
    (void)fprintf(stderr, "Error during model registration: %s\n",
                  rtmGetErrorStatus(SatelliteServicing_Mission_M));

    // Terminate model
    SatelliteServicing_Mission_terminate(SatelliteServicing_Mission_M);
    return(1);
  }

  // ADD INITIAL CONDITIONS HERE

  // Start br initializing all cubesats to zero
  for (int i=0;i<3;i++) {
    SatelliteServicing_Mission_P.cubesat[0].IC.rel_position[i] = 0;
    SatelliteServicing_Mission_P.cubesat[0].IC.rel_velocity[i] = 0;
    SatelliteServicing_Mission_P.cubesat[1].IC.rel_position[i] = 0;
    SatelliteServicing_Mission_P.cubesat[1].IC.rel_velocity[i] = 0;
    SatelliteServicing_Mission_P.cubesat[2].IC.rel_position[i] = 0;
    SatelliteServicing_Mission_P.cubesat[2].IC.rel_velocity[i] = 0;
    SatelliteServicing_Mission_P.cubesat[3].IC.rel_position[i] = 0;
    SatelliteServicing_Mission_P.cubesat[3].IC.rel_velocity[i] = 0;
  }
  // Set desired initial state based on number of agents
  if (nAgents > 0) {
      // 1st agent is being trained
      SatelliteServicing_Mission_P.cubesat[0].IC.rel_position[0] = initial_conditions[0];
      SatelliteServicing_Mission_P.cubesat[0].IC.rel_position[1] = initial_conditions[1];
      SatelliteServicing_Mission_P.cubesat[0].IC.rel_position[2] = initial_conditions[2];
      SatelliteServicing_Mission_P.cubesat[0].IC.rel_velocity[0] = initial_conditions[3];
      SatelliteServicing_Mission_P.cubesat[0].IC.rel_velocity[1] = initial_conditions[4];
      SatelliteServicing_Mission_P.cubesat[0].IC.rel_velocity[2] = initial_conditions[5];
  }
  if (nAgents > 1) {
      // 2nd agent is being trained
      SatelliteServicing_Mission_P.cubesat[1].IC.rel_position[0] = initial_conditions[6];
      SatelliteServicing_Mission_P.cubesat[1].IC.rel_position[1] = initial_conditions[7];
      SatelliteServicing_Mission_P.cubesat[1].IC.rel_position[2] = initial_conditions[8];
      SatelliteServicing_Mission_P.cubesat[1].IC.rel_velocity[0] = initial_conditions[9];
      SatelliteServicing_Mission_P.cubesat[1].IC.rel_velocity[1] = initial_conditions[10];
      SatelliteServicing_Mission_P.cubesat[1].IC.rel_velocity[2] = initial_conditions[11];
  }
  if (nAgents > 2) {
      // 3rd agent is being trained
      SatelliteServicing_Mission_P.cubesat[2].IC.rel_position[0] = initial_conditions[12];
      SatelliteServicing_Mission_P.cubesat[2].IC.rel_position[1] = initial_conditions[13];
      SatelliteServicing_Mission_P.cubesat[2].IC.rel_position[2] = initial_conditions[14];
      SatelliteServicing_Mission_P.cubesat[2].IC.rel_velocity[0] = initial_conditions[15];
      SatelliteServicing_Mission_P.cubesat[2].IC.rel_velocity[1] = initial_conditions[16];
      SatelliteServicing_Mission_P.cubesat[2].IC.rel_velocity[2] = initial_conditions[17];
  }
  if (nAgents > 3) {
      // 4th agent is being trained
      SatelliteServicing_Mission_P.cubesat[3].IC.rel_position[0] = initial_conditions[18];
      SatelliteServicing_Mission_P.cubesat[3].IC.rel_position[1] = initial_conditions[19];
      SatelliteServicing_Mission_P.cubesat[3].IC.rel_position[2] = initial_conditions[20];
      SatelliteServicing_Mission_P.cubesat[3].IC.rel_velocity[0] = initial_conditions[21];
      SatelliteServicing_Mission_P.cubesat[3].IC.rel_velocity[1] = initial_conditions[22];
      SatelliteServicing_Mission_P.cubesat[3].IC.rel_velocity[2] = initial_conditions[23];
  }

  SatelliteServicing_Mission_P.orbit.mean_motion = mean_motion;


  SatelliteServicing_Mission_M->Timing.stepSize0 = simStepSize;

  // Initialize model
  SatelliteServicing_Mission_initialize(SatelliteServicing_Mission_M);

  //printf("Mass: %9.5f\n",SatelliteServicing_Mission_P.cubesat[0].mass);
  //printf("Mean Motion: %9.5f\n",mean_motion);

  // Get the number of faces on the inspection polyhedron
  *nFaces = (int) sizeof(SatelliteServicing_Mission_Y.ControlError)/sizeof(*SatelliteServicing_Mission_Y.ControlError);
  //*nFaces = (int) sizeof(SatelliteServicing_Mission_Y.Observations)/sizeof(*SatelliteServicing_Mission_Y.Observations);
  //printf("Number of faces: %d\n",*nFaces);


  return(0);
}

//
// The example main function illustrates what is required by your
// application code to initialize, execute, and terminate the generated code.
// Attaching rt_OneStep to a real-time clock is target specific. This example
// illustrates how you do this relative to initializing the model.
//
//int_T main(int_T argc, const char *argv[])for (int i=3*nAgents; i<3*ncppAgents; i++) {
extern "C" int_T sim_wrapper(int_T nAgents, int_T nFaces, real_T stopTime, real_T controlStepSize,  real_T* actions, real_T* observations, int_T* coverage, int_T* dones, real_T* simTime)
{

  // Unused arguments
  //(void)(argc);
  //(void)(argv);

// External inputs (root inport signals with default storage)
//struct ExtU_SatelliteServicing_Missi_T {
//  real_T ManipulatorActions[3];        // '<Root>/ManipulatorActions'
//};

// External outputs (root outports fed by signals with default storage)
//struct ExtY_SatelliteServicing_Missi_T {
//  real_T Observations[34];             // '<Root>/Observations'
//  real_T ControlError[13];             // '<Root>/ControlError'
//};

// External inputs (root inport signals with default storage)
struct ExtU_SatelliteServicing_Missi_T {
  real_T ManipulatorActions[3];        // '<Root>/ManipulatorActions'
};

// External outputs (root outports fed by signals with default storage)
//struct ExtY_SatelliteServicing_Missi_T {
//  real_T Observations[282];            // '<Root>/Observations'
//  real_T ControlError;                 // '<Root>/ControlError'
//};

  double modelBaseStepSize = SatelliteServicing_Mission_M->Timing.stepSize0;
  int nBaseSteps = int(controlStepSize/modelBaseStepSize);

  int ncppAgents = 4;

  // Set the inputs for the model
  for (int i=0; i<nAgents; i++) {
      SatelliteServicing_Mission_U.ManipulatorActions[i] = actions[i];
  }


  // Simulating the model step behavior (in non real-time) to
  //   simulate model behavior at stop time.
  for (int s=0;s<nBaseSteps; s++) {
      rt_OneStep(SatelliteServicing_Mission_M);
  }

  // Collect observations
  for (int i=0; i<36; i++) {
       observations[i] = SatelliteServicing_Mission_Y.Observations[i];
  }

  // Collect coverage data 
  for (int i=0; i<nFaces; i++) {
       coverage[i] = (int) SatelliteServicing_Mission_Y.ControlError[i];
  }
  //printf("Observations: %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n",SatelliteServicing_Mission_Y.Observations[0],SatelliteServicing_Mission_Y.Observations[1],SatelliteServicing_Mission_Y.Observations[2],SatelliteServicing_Mission_Y.Observations[3],SatelliteServicing_Mission_Y.Observations[4],SatelliteServicing_Mission_Y.Observations[5],SatelliteServicing_Mission_Y.Observations[6],SatelliteServicing_Mission_Y.Observations[7],SatelliteServicing_Mission_Y.Observations[8]);

  double current_time = rtmGetT(SatelliteServicing_Mission_M);
  *simTime = current_time;
  if (int(*simTime*1e6) % int(10.0*1e6) == 0) {
      //printf("Current Time: %6.3f\n",*simTime);
      //printf("Actions: %6.3f %6.3f %6.3f\n",actions[0],actions[1],actions[2]);
  }
  //printf("Current Time: %6.3f\n",*simTime);

  // Determine if simulation has reached its end time
  if (rtmGetT(SatelliteServicing_Mission_M) >= stopTime) {
      rtmSetStopRequested(SatelliteServicing_Mission_M,1);
      printf("Terminating CPP simulation\n");
      dones[0] = 1;
      SatelliteServicing_Mission_terminate(SatelliteServicing_Mission_M);
  } else {
      dones[0] = 0;
  }
  dones[1] = 0;

  return 0;
}

extern "C" int_T sim_terminate()
{
  // Terminate model
  SatelliteServicing_Mission_terminate(SatelliteServicing_Mission_M);

  return 0;
}

// Declare external functions to be accessed from Python
extern "C" {
    int_T sim_wrapper(int_T nAgents, int_T nFaces, real_T stopTime, real_T controlStepSize,  real_T* actions, real_T* observations, int_T* coverage, int_T* dones, real_T* simTime);
    int_T sim_init(real_T simStepSize, int_T nAgents, real_T* initial_conditions, real_T mean_motion, int_T* nFaces);
    int_T sim_terminate();
}

//
// File trailer for generated code.
//
// [EOF]
//
