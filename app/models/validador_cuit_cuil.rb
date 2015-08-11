class ValidadorCuitCuil

  def validardigitoverificador(numerocuitcuil)
    mult = [5, 4, 3, 2, 7, 6, 5, 4, 3, 2 ]
    nums = numerocuitcuil.split("").map(&:to_i)
    total = 0
    i = 0
    num = 5
    while i < mult.length do
        total += nums[i] * mult[i]
        i +=1
      end
      resto = total % 11;
      resultado = resto == 0 ? 0 : resto == 1 ? 9 : 11 - resto;
      resultado == nums.last
    end
  end
