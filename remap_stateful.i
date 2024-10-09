[Mesh]
  [./square]
    type = GeneratedMeshGenerator
    nx = 10
    ny = 10
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
      projected_props = 'plastic_strain stress total_strain elastic_strain plastic_internal_parameter plastic_transverse_direction'
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
  [./mc_int]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./yield_fcn]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./_var_total_strain_0]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_total_strain_1]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_total_strain_2]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_total_strain_3]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_total_strain_4]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_total_strain_5]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_total_strain_6]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_total_strain_7]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_total_strain_8]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_plastic_strain_0]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_plastic_strain_1]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_plastic_strain_2]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_plastic_strain_3]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_plastic_strain_4]
    family = MONOMIAL
    order = FIRST
    # [./InitialCondition]
    #     type = ConstantIC
    #     value = -0.001
    # [../]
  [../]
  [./_var_plastic_strain_5]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_plastic_strain_6]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_plastic_strain_7]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_plastic_strain_8]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_elastic_strain_0]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_elastic_strain_1]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_elastic_strain_2]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_elastic_strain_3]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_elastic_strain_4]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_elastic_strain_5]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_elastic_strain_6]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_elastic_strain_7]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_elastic_strain_8]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_stress_0]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_stress_1]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_stress_2]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_stress_3]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_stress_4]
    family = MONOMIAL
    order = FIRST
    [./InitialCondition]
      type = FunctionIC
      function = -10000
    [../]
  [../]
  [./_var_stress_5]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_stress_6]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_stress_7]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_stress_8]
    family = MONOMIAL
    order = FIRST
  [../]
  [./_var_plastic_internal_parameter_0]
    family = MONOMIAL
    order = FIRST
  [../]
[]


 
[AuxKernels]
  [./mc_int_auxk]
    type = MaterialStdVectorAux
    property = plastic_internal_parameter
    variable = mc_int
  [../]
  [./yield_fcn_auxk]
    type = MaterialStdVectorAux
    property = plastic_yield_function
    variable = yield_fcn
  [../]
[]

[UserObjects]
  [./mc_coh]
    type = SolidMechanicsHardeningConstant
    value = 10e3
  [../]
  [./mc_phi]
    type = SolidMechanicsHardeningConstant
    value = 0.2
  [../]
  [./mc_psi]
    type = SolidMechanicsHardeningConstant
    value = 0.2
  [../]
  [./mc]
    type = SolidMechanicsPlasticMohrCoulomb
    cohesion = mc_coh
    friction_angle = mc_phi
    dilation_angle = mc_psi
    mc_tip_smoother = 0
    mc_edge_smoother = 25
    yield_function_tolerance = 1E-3
    internal_constraint_tolerance = 1E-8
  [../]
[]

[Materials]
#   [ps_int]
#     type = InterpolatedStatefulMaterialRankTwoTensor
#     old_state = '_var_plastic_strain_0 _var_plastic_strain_1 _var_plastic_strain_2 _var_plastic_strain_3 _var_plastic_strain_4 _var_plastic_strain_5  _var_plastic_strain_6 _var_plastic_strain_7 _var_plastic_strain_8'
#     prop_name = plastic_strain
#   []
#   [ts_int]
#     type = InterpolatedStatefulMaterialRankTwoTensor
#     old_state = '_var_total_strain_0 _var_total_strain_1 _var_total_strain_2 _var_total_strain_3 _var_total_strain_4 _var_total_strain_5 _var_total_strain_6 _var_total_strain_7 _var_total_strain_8'
#     prop_name =  total_strain
#   []
#   [es_int]
#     type = InterpolatedStatefulMaterialRankTwoTensor
#     old_state = '_var_elastic_strain_0 _var_elastic_strain_1 _var_elastic_strain_2 _var_elastic_strain_3 _var_elastic_strain_4 _var_elastic_strain_5 _var_elastic_strain_6 _var_elastic_strain_7 _var_elastic_strain_8'
#     prop_name =  elastic_strain
#   []
#   [st_int]
#     type = InterpolatedStatefulMaterialRankTwoTensor
#     old_state = '_var_stress_0 _var_stress_1 _var_stress_2 _var_stress_3 _var_stress_4 _var_stress_5 _var_stress_6 _var_stress_7 _var_stress_8'
#     prop_name =  stress
#   []
  [./elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 100e6
    poissons_ratio = 0.3
  [../]
  [./mc]
    type = ComputeMultiPlasticityStress
    ep_plastic_tolerance = 1E-9
    plastic_models = mc
    perform_finite_strain_rotations = false
    min_stepsize = 0.01
    ignore_failures = true
  [../]
[]


[Executioner]
  end_time = 10
  num_steps= 10
  solve_type = NEWTON
  type = Transient

  line_search = 'basic' 
  nl_abs_tol = 1e-10
  automatic_scaling = true 
  scaling_group_variables = 'disp_x disp_y'

  l_max_its = 30
  nl_max_its = 1000
  
  petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -ksp_type -ksp_gmres_restart'
  petsc_options_value = ' lu      2              lu            gmres     200'
[]

[Outputs]
  file_base = output/test
  exodus = true
  [./vtk]
    type = VTK
    use_displaced = true
    execute_on = 'initial timestep_end'
  [../]
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
  [interpolated_s_yy]
    type = PointValue
    point = '0.5 0.5 0'
    variable = _var_total_strain_4
    execute_on = 'timestep_end'
  []
  [interpolated_ps_yy]
    type = PointValue
    point = '0.5 0.5 0'
    variable = _var_plastic_strain_4
    execute_on = 'timestep_end'
  []
  [interpolated_es_yy]
    type = PointValue
    point = '0.5 0.5 0'
    variable = _var_elastic_strain_4
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
