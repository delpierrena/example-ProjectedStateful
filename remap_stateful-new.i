
[Mesh]
  [./square]
    type = GeneratedMeshGenerator
    nx = 5
    ny = 5
    dim = 2
    ymax = 1
    xmax = 1
  [../]
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Physics]
  [SolidMechanics]
    [QuasiStatic]
      [all]
        strain = SMALL
        incremental = true
        add_variables = true
        generate_output = 'stress_xx stress_yy stress_xy stress_zz stress_xz strain_xx strain_yy strain_xy plastic_strain_xx plastic_strain_yy plastic_strain_xy secondinv_strain elastic_strain_xx elastic_strain_yy elastic_strain_xy'
      []
    []
  []
[]

[ProjectedStatefulMaterialStorage]
  [test]
    projected_props = 'rotation_total stress elastic_strain combined_inelastic_strain'
    family = MONOMIAL
    order = FIRST
  []
[]

[BCs]
  [./bottom_zero_y]
    type = DirichletBC
    variable = disp_y
    boundary = 'bottom'
    value = '0'
  [../]
  [./bottom_zero_x]
    type = FunctionNeumannBC
    variable = disp_y
    boundary = 'top'
    function = -1000*t
  [../]
  [./left_x]
    type = DirichletBC
    variable = disp_x
    boundary = 'left'
    value = 0
  [../]
  [./right_x]
    type = DirichletBC
    variable = disp_x
    boundary = 'right'
    value = 0
  [../]
[]

[AuxVariables]
  [./_var_stress_4]
    family = MONOMIAL
    order = FIRST
    [./InitialCondition]
      type = FunctionIC
      function = -10000
    [../]
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 20e6
    poissons_ratio = 0.3
  [../]
  [isotropic_plasticity]
    type = IsotropicPlasticityStressUpdate
    yield_stress = 10e3
    hardening_function = 0
    # use_interpolated_state = true
  []
  [./radial_return_stress]
    type = ComputeMultipleInelasticStress
    tangent_operator = elastic
    inelastic_models = 'isotropic_plasticity'
    use_interpolated_state = true
  [../]
[]


[Executioner]
  end_time = 10
  num_steps= 10
  solve_type = NEWTON
  type = Transient

  line_search = 'basic' #c est vraiment ce parametre qui fait la difference 
  nl_abs_tol = 1e-10
  automatic_scaling = true #combine avec celui ci 
  scaling_group_variables = 'disp_x disp_y'

  l_max_its = 30
  nl_max_its = 1000
  
  petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -ksp_type -ksp_gmres_restart'
  petsc_options_value = ' lu      2              lu            gmres     200'
[]

[Outputs]
  file_base = output/slope_failure_{time}
  exodus = true
[]

[Debug]
  show_material_props = true
  show_actions = true
  show_execution_order = TIMESTEP_BEGIN
[]

[Postprocessors]
  [interpolated_stress_yy]
    type = PointValue
    point = '0.5 0.5 0'
    variable = _var_stress_4
    execute_on = 'timestep_end'
  []
  [s_yy]
    type = PointValue
    point = '0.5 0.5 0'
    variable =  strain_yy
    execute_on = 'timestep_end'
  []
  [ps_yy]
    type = PointValue
    point = '0.5 0.5 0'
    variable =  plastic_strain_yy
    execute_on = 'timestep_end'
  []
  [es_yy]
    type = PointValue
    point = '0.5 0.5 0'
    variable = elastic_strain_yy
    execute_on = 'timestep_end'
  []
  [stress_yy]
    type = PointValue
    point = '0.5 0.5 0'
    variable = stress_yy
    execute_on = 'timestep_end'
  []
[]