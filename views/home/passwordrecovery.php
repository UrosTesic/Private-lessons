<!--
tu130060
sa130068
-->
<div class="lost-password container">
<div class="col-sm-4 col-sm-offset-1">
<h3>Zaboravljena lozinka</h3>
	<form role="form" action>
		<div class="form-group has-error">

			<label for="email">E-mail</label>
			<input name="email" type="email" class="form-control" id="email" placeholder="email@email.com" required/>
                        <?php
                        if($status == -1):
                            echo '<div class="error-message">E-mail ne postoji u bazi</div>';
						elseif ($status == 1):
							echo '<div class="error-message">Poslali smo link za povratak lozinke na Vaš email</div>';
                        endif;
                        ?>
		</div>

		<button type="submit" class="btn btn-lg btn-primary">Povrati lozinku</button>
	</form>
</div>

<div class="hidden-xs col-sm-6 col-md-5 col-lg-4 col-lg-offset-1">
<img src="img/sloth.png" class="img-responsive center-block" >
</div>

</div>