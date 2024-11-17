<?php

use App\Models\Assignment;
use App\Models\Post;
use App\Models\User;
use App\Models\UvaTopic;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('temp_posts', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(User::class)->constrained()->onDelete('cascade')->comment('外鍵_使用者ID');
            $table->foreignIdFor(Post::class)->nullable()->constrained()->onDelete('set null')->comment('外鍵_原始貼文ID');
            $table->foreignIdFor(Assignment::class)->constrained()->onDelete('cascade')->comment('外鍵_作業ID');
            $table->foreignIdFor(UvaTopic::class)->constrained()->onDelete('cascade')->comment('外鍵_題目ID');
            $table->text('video_url');
            $table->text('video_id');
            $table->text('video_pic_url');
            $table->text('content');
            $table->text('code')->nullable();
            $table->text('code_editor_type')->nullable();
            $table->text('code_type')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('temp_posts');
    }
};
