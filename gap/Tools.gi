#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#! @Chapter Tool methods
##
#############################################################################

############################################
##
#! @Section Tools to simplify the code
##
############################################

InstallMethod( DeduceMapFromMatrixAndRangeLeft,
               [ IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedLeftModulesObject ],
  function( matrix, range_object )
    local homalg_graded_ring, source_object, non_zero_entries_index, expanded_degree_list, j, k, degrees_of_matrix_rows,
         degrees_of_source_object;

      # check if the input is valid
      if not IsIdenticalObj( HomalgRing( matrix ), UnderlyingHomalgGradedRing( range_object ) ) then
      
        return Error( "The matrix must be defined over the same ring that the range_object was defined over. \n" );
       
      fi;
      
      # the input is valid, so continue by setting the homalg_graded_ring
      homalg_graded_ring := HomalgRing( matrix );
      
      # check if the mapping_matrix is zero
      if IsZero( matrix ) then
        
          # if so, the kernel object is the zero module
          source_object := CAPCategoryOfProjectiveGradedLeftModulesObject( [ ], homalg_graded_ring );
        
        else
        
          # the mapping_matrix is not zero, thus let us compute the source object...
          
          # figure out the (first) non-zero entries per row of the kernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerRow( matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( range_object ) ) ] do
          
            for k in [ 1 .. DegreeList( range_object )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( range_object )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the kernel matrix
          degrees_of_matrix_rows := NonTrivialDegreePerRow( matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_source_object := List( [ 1 .. Length( degrees_of_matrix_rows ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_matrix_rows ) ] do
        
            degrees_of_source_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 + degrees_of_matrix_rows[ j ], 1 ];
          
          od;
        
          # and compute the kernel object
          source_object := CAPCategoryOfProjectiveGradedLeftModulesObject( degrees_of_source_object, homalg_graded_ring );

        fi;
                               
        # and return the mapping
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source_object, matrix, range_object );

end );


InstallMethod( DeduceMapFromMatrixAndSourceLeft,
               [ IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedLeftModulesObject ],
  function( matrix, source_object )
    local homalg_graded_ring, range_object, non_zero_entries_index, expanded_degree_list, j, k, degrees_of_matrix_columns,
         degrees_of_range_object;

      # check if the input is valid
      if not IsIdenticalObj( HomalgRing( matrix ), UnderlyingHomalgGradedRing( source_object ) ) then
      
        return Error( "The matrix must be defined over the same ring that the range_object was defined over. \n" );
       
      fi;
      
      # the input is valid, so continue by setting the homalg_graded_ring
      homalg_graded_ring := HomalgRing( matrix );
      
      # check if the mapping_matrix is zero
      if IsZero( matrix ) then
        
          # if so, the kernel object is the zero module
          range_object := CAPCategoryOfProjectiveGradedLeftModulesObject( [ ], homalg_graded_ring );
        
        else
        
          # the mapping_matrix is not zero, thus let us compute the range object...
          
          # figure out the (first) non-zero entries per row of the kernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerColumn( matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( source_object ) ) ] do
          
            for k in [ 1 .. DegreeList( source_object )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( source_object )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the kernel matrix
          degrees_of_matrix_columns := NonTrivialDegreePerColumn( matrix );

          # initialise the degree list of the kernel_object
          degrees_of_range_object := List( [ 1 .. Length( degrees_of_matrix_columns ) ] );

          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_matrix_columns ) ] do

            degrees_of_range_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 - degrees_of_matrix_columns[ j ], 1 ];

          od;

          # and compute the kernel object
          range_object := CAPCategoryOfProjectiveGradedLeftModulesObject( degrees_of_range_object, homalg_graded_ring );

        fi;

        # and return the mapping
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source_object, matrix, range_object );

end );


InstallMethod( DeduceMapFromMatrixAndRangeRight,
               [ IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedRightModulesObject ],
  function( matrix, range_object )
    local homalg_graded_ring, source_object, non_zero_entries_index, expanded_degree_list, j, k, degrees_of_matrix_columns,
         degrees_of_source_object;

      # check if the input is valid
      if not IsIdenticalObj( HomalgRing( matrix ), UnderlyingHomalgGradedRing( range_object ) ) then
      
        return Error( "The matrix must be defined over the same ring that the range_object was defined over. \n" );
       
      fi;
      
      # the input is valid, so continue by setting the homalg_graded_ring
      homalg_graded_ring := HomalgRing( matrix );

      # check if the cokernel matrix is zero
      if IsZero( matrix ) then

        # construct the kernel_object
        source_object := CAPCategoryOfProjectiveGradedRightModulesObject( [ ], homalg_graded_ring );
        
      else

          # figure out the (first) non-zero entries per row of the kernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerColumn( matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( range_object ) ) ] do
          
            for k in [ 1 .. DegreeList( range_object )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( range_object )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_matrix_columns := NonTrivialDegreePerColumn( matrix );

          # initialise the degree list of the kernel_object
          degrees_of_source_object := List( [ 1 .. Length( degrees_of_matrix_columns ) ] );

          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_matrix_columns ) ] do
        
            degrees_of_source_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 + degrees_of_matrix_columns[ j ], 1 ];
          
          od;
        
          # construct the kernel_object
          source_object := CAPCategoryOfProjectiveGradedRightModulesObject( degrees_of_source_object, homalg_graded_ring );

        fi;

        # and return the kernel embedding
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source_object, matrix, range_object );

end );


InstallMethod( DeduceMapFromMatrixAndSourceRight,
               [ IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedRightModulesObject ],
  function( matrix, source_object )
    local homalg_graded_ring, range_object, non_zero_entries_index, expanded_degree_list, j, k, degrees_of_matrix_rows,
         degrees_of_range_object;

      # check if the input is valid
      if not IsIdenticalObj( HomalgRing( matrix ), UnderlyingHomalgGradedRing( source_object ) ) then
      
        return Error( "The matrix must be defined over the same ring that the range_object was defined over. \n" );
       
      fi;
      
      # the input is valid, so continue by setting the homalg_graded_ring
      homalg_graded_ring := HomalgRing( matrix );
                  
      # check if the cokernel matrix is zero
      if IsZero( matrix ) then
        
        # if so, the cokernel object is the zero module
        range_object := CAPCategoryOfProjectiveGradedRightModulesObject( [ ], homalg_graded_ring );
          
      else
        
        # the matrix is not zero, thus let us compute the range object...
          
        # figure out the (first) non-zero entries per row of the cokernel matrix
        non_zero_entries_index := PositionOfFirstNonZeroEntryPerRow( matrix );
          
        # expand the degree_list of the range of the morphism
        expanded_degree_list := [];
        for j in [ 1 .. Length( DegreeList( source_object ) ) ] do
          
          for k in [ 1 .. DegreeList( source_object )[ j ][ 2 ] ] do
            
            Add( expanded_degree_list, DegreeList( source_object )[ j ][ 1 ] );
            
          od;
          
        od;
          
        # compute the degrees of the rows of the cokernel matrix
        degrees_of_matrix_rows := NonTrivialDegreePerRow( matrix );
        
        # initialise the degree list of the cokernel_object
        degrees_of_range_object := List( [ 1 .. Length( degrees_of_matrix_rows ) ] );
        
        # and now compute the degrees of the cokernel_object
        for j in [ 1 .. Length( degrees_of_matrix_rows ) ] do
        
          degrees_of_range_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 - degrees_of_matrix_rows[ j ], 1 ];
          
        od;
        
        # and from them the cokernel object
        range_object := CAPCategoryOfProjectiveGradedRightModulesObject( degrees_of_range_object, homalg_graded_ring );

      fi;

      # and return the mapping morphism
      return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source_object, matrix, range_object );        
        
end );